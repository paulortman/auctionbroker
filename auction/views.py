import decimal

from braces.views import GroupRequiredMixin, UserPassesTestMixin
from django.conf import settings
from django.contrib import messages
from django.contrib.staticfiles import finders
from django.core.exceptions import ValidationError
from django.db.models import Q, Sum
from django.forms import formset_factory
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.template.loader import render_to_string
from django.urls import reverse, reverse_lazy
from django.utils import timezone
from django.utils.text import slugify
from django.views import View
from django.views.generic import ListView, DetailView, UpdateView, CreateView, DeleteView, TemplateView, FormView
from extra_views import FormSetView
from weasyprint import HTML, CSS
from weasyprint.fonts import FontConfiguration

from .models import Item, Patron, Purchase, Booth, Payment, AuctionItem, round_scheduled_sale_time, Fee, PricedItem
from auction.utils import D, USD, calc_cc_fee_amount
from .forms import PatronForm, PricedItemPurchaseForm, CheckoutPatronForm, CheckoutPurchaseForm, BoothForm, \
    PaymentForm, ItemBiddingForm, CheckoutConfirmForm, PurchaseForm, PatronCreateForm, \
    PatronDonateForm, AuctionItemEditForm, AuctionItemCreateForm, DonateForm, PatronPaymentCashForm, \
    PatronPaymentCCForm, PatronPaymentCCFeeForm, PurchaseEditForm


class HonorNextMixin:
    def get_success_url(self):
        """
        This allows any class view to honor an action with a 'next' query string attached.  If the 'next' querystring is
        not provided, resume default behavior.

        :return:
        """
        next_url = self.request.GET.get('next', None)  # here method should be GET or POST.
        if next_url:
            return next_url
        else:
            return super().get_success_url()


class AuctionItemSearchMixin:
    def _query_fields(self, terms):
        self._query_terms = terms

        query = Q()
        for t in terms:
            query |= Q(name__icontains=t)
            query |= Q(item_number__icontains=t)
            query |= Q(long_desc__icontains=t)
        return query

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if hasattr(self, '_query_terms'):
            context['q'] = ' '.join(self._query_terms)
        return context


class AuctionItemMixin(GroupRequiredMixin, HonorNextMixin):
    group_required = 'auction_managers'
    raise_exception = True

    def get_queryset(self):
        return self.model.objects.all().order_by('sale_time','scheduled_sale_time')

    def get_object(self):
        item_number = self.kwargs.get('item_number', None)
        if not item_number:
            raise Exception("item_number not specified")
        return self.model.objects.get(item_number=item_number)


class AuctionItemList(AuctionItemMixin, ListView):
    model = AuctionItem


class AuctionItemManagement(AuctionItemSearchMixin, AuctionItemMixin, ListView):
    model = AuctionItem
    template_name = 'auction/auctionitem_management.html'

    def get_queryset(self):
        qs = super().get_queryset()

        category_slug = self.kwargs.get('category', None)
        if category_slug:
            category = AuctionItem.category_from_slug(category_slug)
            if category:
                qs = qs.filter(category=category)

        filter = self.request.GET.get('q')
        if filter:
            terms = filter.split()
            query = self._query_fields(terms)
            qs = qs.filter(query)

        return qs.select_related('purchase', 'purchase__patron', 'donor')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['auction_category'] = self.kwargs.get('category', None)
        return context


class AuctionItemDetail(AuctionItemMixin, DetailView):
    model = AuctionItem


class AuctionItemCreate(AuctionItemMixin, CreateView):
    model = AuctionItem
    form_class = AuctionItemCreateForm

    def form_valid(self, form):
        form.instance.booth = Booth.objects.get(name__iexact='auction')

        form.instance.save()
        i = form.instance
        msg = "Auction Item '{name}' ({num}) created successfully.".format(name=i.name, num=i.item_number)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')

        if 'save_and_add_another' in self.request.POST:
            return redirect('item_create')
        if 'save_and_return_to_list' in self.request.POST:
            return redirect('item_management', category=i.category)

        return redirect('item_detail', item_number=i.item_number)

    def get_initial(self):
        initial = super().get_initial()

        # mra = most recently added
        try:
            mra_scheduled_sale_time = AuctionItem.objects.all().order_by('-ctime')[0].scheduled_sale_time
        except (AuctionItem.DoesNotExist, IndexError):
            mra_scheduled_sale_time = timezone.now()
        mra_scheduled_sale_time += timezone.timedelta(minutes=settings.AUCTIONITEM_SCHEDULED_TIME_INCREMENT)
        initial['scheduled_sale_time'] = round_scheduled_sale_time(mra_scheduled_sale_time)

        return initial


class AuctionItemUpdate(AuctionItemMixin, UpdateView):
    model = AuctionItem
    form_class = AuctionItemEditForm

    def form_valid(self, form):
        if 'is_purchased' in form.changed_data and form.cleaned_data['is_purchased'] is False:
            form.instance.void_purchase()
        return super().form_valid(form)


class AuctionItemDelete(AuctionItemMixin, DeleteView):
    template_name = 'auction/generic_confirm_delete.html'
    model = AuctionItem


class BoothList(GroupRequiredMixin, ListView):
    model = Booth
    group_required = u'admins'


class BoothDetail(GroupRequiredMixin, DetailView):
    model = Booth
    group_required = u'admins'


class BoothCreate(GroupRequiredMixin, CreateView):
    model = Booth
    form_class = BoothForm
    group_required = u'admins'


class BoothUpdate(GroupRequiredMixin, UpdateView):
    model = Booth
    form_class = BoothForm
    group_required = u'admins'


class BoothDelete(GroupRequiredMixin, DeleteView):
    template_name = 'auction/generic_confirm_delete.html'
    model = Booth
    group_required = u'admins'


class PurchaseList(GroupRequiredMixin, ListView):
    model = Purchase
    group_required = u'account_managers'
    raise_exception = True


class PurchaseDetail(DetailView):
    model = Purchase
    group_required = u'account_managers'
    raise_exception = True


class PurchaseCreate(CreateView):
    model = Purchase
    form_class = PurchaseForm
    group_required = u'account_managers'
    raise_exception = True


class PurchaseUpdate(HonorNextMixin, FormView):
    model = Purchase
    form_class = PurchaseEditForm
    group_required = u'account_managers'
    raise_exception = True
    template_name = 'auction/payment_form.html'

    def get_initial(self):
        self.object = self.get_object()
        initial = {}
        initial['description'] = self.object.item.name
        initial['amount'] = self.object.amount
        return initial

    def get_object(self):
        return Purchase.objects.get(pk=self.kwargs.get('pk'))

    def form_invalid(self, form):
        print('x')
        return super().form_invalid()

    def form_valid(self, form):
        # Priced items are an unuusal case, we ned to adjust the FMV so that editing a price paid doesn't end up
        # creating a donation or negative donations.
        if 'amount' in form.changed_data and hasattr(self.object, 'priceditem'):
            self.object.priceditem.fair_market_value = form.cleaned_data['amount']
            self.object.priceditem.save()
        self.object.item.name = form.cleaned_data['description']
        self.object.item.save()
        self.object.amount = form.cleaned_data['amount']
        self.object.save()
        return super().form_valid(form)


class PurchaseDelete(HonorNextMixin, DeleteView):
    template_name = 'auction/generic_confirm_delete.html'
    model = Purchase
    group_required = u'account_managers'
    raise_exception = True
    success_url = reverse_lazy('purchase_list')

    # def get_success_url(self):
    #     patron = self.get_object().patron
    #     return reverse('patron_detail', kwargs={'pk': patron.pk})

class FeeDelete(HonorNextMixin, DeleteView):
    template_name = 'auction/generic_confirm_delete.html'
    model = Fee
    group_required = u'account_managers'
    raise_exception = True


class PaymentList(HonorNextMixin, ListView):
    model = Payment
    group_required = u'account_managers'
    raise_exception = True


class PaymentDetail(HonorNextMixin, DetailView):
    model = Payment
    group_required = u'account_managers'
    raise_exception = True


class PaymentCreate(HonorNextMixin, CreateView):
    model = Payment
    form_class = PaymentForm
    group_required = u'account_managers'
    raise_exception = True


class PaymentUpdate(HonorNextMixin, UpdateView):
    model = Payment
    form_class = PaymentForm
    group_required = u'account_managers'
    raise_exception = True


class PaymentDelete(HonorNextMixin, DeleteView):
    template_name = 'auction/generic_confirm_delete.html'
    model = Payment
    group_required = u'account_managers'
    raise_exception = True

    def get_success_url(self):
        patron = self.get_object().patron
        return reverse('patron_detail', kwargs={'pk': patron.pk})


class PatronMixin(HonorNextMixin, GroupRequiredMixin):
    model = Patron
    group_required = u'account_managers'
    raise_exception = True

    def get_object(self):
        pk = self.kwargs.get('pk', None)
        if not pk:
            raise Exception("pk not specified")
        return self.model.objects.get(pk=pk)


class PatronSearchMixin:
    def _query_fields(self, terms):
        self._query_terms = terms
        query = Q()
        for t in terms:
            query |= Q(first_name__icontains=t)
            query |= Q(last_name__icontains=t)
            query |= Q(buyer_num__icontains=t)
        return query

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if hasattr(self, '_query_terms'):
            context['q'] = ' '.join(self._query_terms)
        return context


class PatronLookupMixin:
    def _query_fields(self, fields):
        f = {}

        # provide default None values for all the configured fields
        for field in self.lookup_fields:
            f[field] = None
            if field in fields:
                if fields[field] != '':
                    f[field] = fields[field]

        # If everything in the lookup is None, we bail as that is simply all values, which isn't helpful
        if not any(f.values()):
            return None

        # Start with an empty set of restrictions and then AND all field together to refine the lookup
        query = Q()
        if f['first_name']:
            query &= Q(first_name__icontains=f['first_name'])
        if f['last_name']:
            query &= Q(last_name__icontains=f['last_name'])
        if f['address_line1']:
            query &= Q(address_line1__icontains=f['address_line1'])
        if f['address_line2']:
            query &= Q(address_line2__icontains=f['address_line2'])
        if f['address_line3']:
            query &= Q(address_line3__icontains=f['address_line3'])
        return query



class PatronList(PatronSearchMixin, PatronMixin, ListView):
    def get_queryset(self):
        qs = super().get_queryset()

        filter = self.request.GET.get('q')
        if filter:
            terms = filter.split()
            query = self._query_fields(terms)
            qs = qs.filter(query)

        return qs.prefetch_related('payments', 'purchases')


class PatronDetail(PatronMixin, DetailView):
    pass


class PatronEdit(PatronMixin):

    def form_valid(self, form):

        msg = "Patron '{name}' ({num}) edited successfully.".format(name=form.instance.name, num=form.instance.buyer_num)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')

        response = super().form_valid(form)

        if 'save_and_add_another' in self.request.POST:
            response = redirect('patron_create')
        if 'save_and_return_to_list' in self.request.POST:
            response = redirect('patron_list')

        return response


class PatronCreate(PatronEdit, CreateView):
    form_class = PatronCreateForm


class PatronUpdate(PatronEdit, UpdateView):
    form_class = PatronForm


class PatronDelete(PatronMixin, DeleteView):
    template_name = 'auction/generic_confirm_delete.html'


class PatronReceipt(PatronMixin, DetailView):
    template_name = 'auction/patron_receipt.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        meta = {
            'printing_time': timezone.now()
        }
        context['meta'] = meta
        context['patron'] = self.get_object()
        return context

    def get(self, *args, **kwargs):
        self.object = self.get_object()
        context = self.get_context_data(object=self.object)
        font_config = FontConfiguration()
        html = HTML(string=render_to_string(self.template_name, context=context))
        css_files = ['css/bootstrap.min.css', 'css/print.css']
        css_files = ['css/print.css',]
        css_str = ""
        for f in css_files:
            with open(finders.find(f), 'r') as fh:
                css_str += fh.read()
        css = CSS(string=css_str)

        # Create a PDF response and use Weasy to print to it
        response = HttpResponse(content_type="application/pdf")
        response['Content-Disposition'] = 'filename="relief_sale_receipt_{}.pdf"'.format(slugify(self.object.name))
        html.write_pdf(target=response, stylesheets=[css,], font_config=font_config)

        return response


class PatronPaymentWizardMixin:
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['patron'] = self.get_object()
        context['payment_percentage'] = settings.CC_TRANSACTION_FEE_PERCENTAGE * 100
        return context

    def get_initial(self):
        initial = super().get_initial()
        self.object = self.get_object()
        initial['amount'] = self.object.outstanding_balance_no_fees
        return initial

    def dec_to_int(self, d):
        return int(d * 100)

    def int_to_dec(self, i):
        return D(i) / D(100)


class PatronPaymentWizardCash(PatronPaymentWizardMixin, PatronMixin, FormView):
    form_class = PatronPaymentCashForm
    template_name = "auction/patron_payment_wizard_cash.html"

    def get_success_url(self):
        return reverse('patron_detail', kwargs={'pk': self.object.pk})

    def form_valid(self, form):
        patron = self.object
        amount = form.cleaned_data['amount']
        method = form.cleaned_data['method']
        note = form.cleaned_data['note']
        Payment.objects.create(patron=patron, amount=amount, method=method, note=note)
        msg = "Payment of {amount} made by {name}".format(amount=USD(amount), name=patron.name)

        messages.add_message(self.request, messages.INFO, msg, 'alert-success')
        return super().form_valid(form)


class PatronPaymentWizardCC(PatronPaymentWizardMixin, PatronMixin, FormView):
    form_class = PatronPaymentCCForm
    template_name = 'auction/patron_payment_wizard_cc.html'

    def get_success_url(self):
        return reverse('payment_wizard_ccfee', kwargs={'pk': self.object.pk})

    def form_valid(self, form):
        self.request.session['payment_amount'] = self.dec_to_int(form.cleaned_data['amount'])
        return super().form_valid(form)


class PatronPaymentWizardCCFee(PatronPaymentWizardMixin, PatronMixin, FormView):
    form_class = PatronPaymentCCFeeForm
    template_name = 'auction/patron_payment_wizard_ccfee.html'

    def get_success_url(self):
        return reverse('patron_detail', kwargs={'pk': self.object.pk})

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['payment_amount'] = self.int_to_dec(self.request.session.get('payment_amount'))
        context['payment_percentage'] = settings.CC_TRANSACTION_FEE_PERCENTAGE * 100
        context['payment_fee'] = calc_cc_fee_amount(context['payment_amount'])
        return context

    def get_initial(self):
        initial = super().get_initial()
        amount = self.int_to_dec(self.request.session.get('payment_amount'))
        initial['ccfee'] = calc_cc_fee_amount(amount)
        return initial

    def form_valid(self, form):
        patron = self.object
        amount = self.int_to_dec(self.request.session.get('payment_amount'))
        percentage = settings.CC_TRANSACTION_FEE_PERCENTAGE * 100
        ccfee = form.cleaned_data['ccfee']
        total = amount + ccfee
        note = form.cleaned_data['note']
        Fee.objects.create(patron=patron, amount=ccfee, description='Credit Card Fee ({}%)'.format(percentage))
        Payment.objects.create(patron=patron, amount=total, method=Payment.CARD, note=note)
        msg = "Payment of {total} made by {name} (includes {fee} credit card fee)".format(total=USD(total),
                                                                                          name=patron.name,
                                                                                          fee=USD(ccfee))
        del self.request.session['payment_amount']
        return super().form_valid(form)


class PatronDonate(PatronMixin, FormView):
    form_class = PatronDonateForm
    template_name = 'auction/patron_donate.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['patron'] = self.get_object()
        return context

    def form_valid(self, form):
        patron = self.get_object()
        amount = form.cleaned_data['donation']
        note = form.cleaned_data['note']
        Purchase.create_donation(patron=patron, amount=amount, booth=None, note=note)

        msg = "Donation of {amount} made by {name} ({num})".format(
            amount=USD(amount), name=patron.name, num=patron.buyer_num)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')
        return redirect('patron_detail', pk=patron.pk)


class Donate(HonorNextMixin, FormView):
    form_class = DonateForm
    template_name = 'auction/donate.html'
    success_url = reverse_lazy('home')

    def form_valid(self, form):
        buyer_num = form.cleaned_data['buyer_num']
        amount = form.cleaned_data['donation']
        note = form.cleaned_data['note']
        try:
            patron = Patron.objects.get(buyer_num=buyer_num)
        except Patron.DoesNotExist:
            raise ValidationError("Invalid Patron Number -- no patron exists")

        Purchase.create_donation(patron=patron, amount=amount, booth=None, note=note)

        msg = "Donation of {amount} made by {name} ({num})".format(
            amount=USD(amount), name=patron.name, num=patron.buyer_num)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')

        return super().form_valid(form)


class RandomSale(TemplateView):
    template_name = 'dashboard.html'
    def get(self, request, *args, **kwargs):
        from auction.modelfactory import AuctionItemFactory, PatronFactory
        b = PatronFactory.create()
        ai = AuctionItemFactory.create()
        c = Purchase.objects.create(patron=b, amount='1')
        ai.charge = c
        ai.save()
        return super().get(request, args, kwargs)


def priced_item_checkout(request):
    PurchasesFormSet = formset_factory(PricedItemPurchaseForm, extra=2)

    if request.method == 'POST':
        purchases_formset = PurchasesFormSet(request.POST, request.FILES)
        if purchases_formset.is_valid():
            pass
    else:  # GET
        purchases_formset = PurchasesFormSet()
    return render(request, 'auction/add_charge.html', {
        'purchases_formset': purchases_formset
    })


def checkout_auth_func(view, user):
    # allow if the username is in part of the booth name -- truly a hack
    if user.username.lower() in view.booth.name.lower():
        return True
    if user.is_superuser:  # always allow superusers
        return True
    return False


class CheckoutAuthMixin(GroupRequiredMixin, UserPassesTestMixin):
    group_required = 'checkout'
    test_func = checkout_auth_func
    raise_exception = True


class CheckoutPatron(CheckoutAuthMixin, FormView):
    template_name = 'auction/checkout_patron.html'
    form_class = CheckoutPatronForm

    def dispatch(self, request, *args, **kwargs):
        booth_slug = self.kwargs.get('booth_slug')
        self.booth = get_object_or_404(Booth, slug=booth_slug)
        return super(CheckoutPatron, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(CheckoutPatron, self).get_context_data(**kwargs)
        context['booth'] = self.booth
        return context

    def form_valid(self, form):
        buyer_num = form.cleaned_data['buyer_num']
        try:
            patron = Patron.objects.get(buyer_num=buyer_num)
        except Patron.DoesNotExist:
            form.add_error('buyer_num', "Patron {} unknown".format(buyer_num))
            return redirect('checkout_patron', booth_slug=self.booth.slug)

        return redirect('checkout_purchase', buyer_num=patron.buyer_num, booth_slug=self.booth.slug)


class CheckoutPurchase(CheckoutAuthMixin, FormSetView):
    template_name = 'auction/checkout_purchase.html'
    form_class = CheckoutPurchaseForm
    factory_kwargs = {'extra': 10}

    def dispatch(self, request, *args, **kwargs):
        booth_slug = self.kwargs.get('booth_slug')
        buyer_num = self.kwargs.get('buyer_num')
        self.booth = get_object_or_404(Booth, slug=booth_slug)
        self.patron = get_object_or_404(Patron, buyer_num=buyer_num)
        return super(CheckoutPurchase, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(CheckoutPurchase, self).get_context_data(**kwargs)
        context['patron'] = self.patron
        context['booth'] = self.booth
        return context

    def formset_valid(self, formset):
        context = self.get_context_data()
        values = [form.serialize() for form in formset.forms if form.has_changed()]
        self.request.session['purchase_forms'] = values
        purchase_total = sum([form.entry_total for form in formset.forms])
        self.request.session['purchase_total'] = str(purchase_total)

        return redirect('checkout_confirm', buyer_num=self.patron.buyer_num, booth_slug=self.booth.slug)


class CheckoutConfirm(CheckoutAuthMixin, FormView):
    form_class = CheckoutConfirmForm
    template_name = 'auction/checkout_confirm.html'

    def dispatch(self, request, *args, **kwargs):
        booth_slug = self.kwargs.get('booth_slug')
        buyer_num = self.kwargs.get('buyer_num')
        self.booth = get_object_or_404(Booth, slug=booth_slug)
        self.patron = get_object_or_404(Patron, buyer_num=buyer_num)
        return super(CheckoutConfirm, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(CheckoutConfirm, self).get_context_data(**kwargs)
        context['patron'] = self.patron
        context['booth'] = self.booth
        context['purchase_total'] = D(self.request.session['purchase_total'])
        return context

    def form_valid(self, form):
        purchase_total = D(self.request.session['purchase_total'])

        # Save the purchase for the patron
        p = Purchase.create_priced_item(patron=self.patron, amount=purchase_total, booth=self.booth)

        # Clear the session state
        del(self.request.session['purchase_total'])
        del(self.request.session['purchase_forms'])

        msg = "Completed Purchase of {amount} by {name} ({number})".format(
            amount=USD(purchase_total), name=self.patron.name, number=self.patron.buyer_num)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')

        return redirect('checkout_patron', booth_slug=self.booth.slug)


class BiddingRecorder(GroupRequiredMixin, FormView):
    model = Item
    form_class = ItemBiddingForm
    template_name = 'auction/bidding_recorder.html'
    group_required = 'auction_managers'

    def dispatch(self, request, *args, **kwargs):
        item_number = self.kwargs.get('item_number')
        self.item = get_object_or_404(AuctionItem, item_number=item_number)
        return super(BiddingRecorder, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(BiddingRecorder, self).get_context_data(**kwargs)
        context['item'] = self.item
        return context

    def form_valid(self, form):
        buyer_num = form.cleaned_data['buyer_num']
        patron = get_object_or_404(Patron, buyer_num=buyer_num)
        amount = form.cleaned_data['amount']
        if self.item.is_purchased:
            self.item.void_purchase()
        purchase = Purchase.purchase_item(patron=patron, amount=amount, item=self.item)
        msg = "{b_num} ({b_name}) purchased {i_name} ({i_num}) in the amount of {amount}".format(
            b_num=patron.buyer_num, b_name=patron.name, i_name=self.item.name, i_num=self.item.item_number,
            amount=USD(amount))
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')
        return redirect('item_management', category=self.item.category)



class ModelSearch(View):
    def _query_fields(self, terms):
        raise NotImplemented

    def _to_json(self, query):
        return list(query.values())

    def get(self, *args, **kwargs):
        query_string = self.request.GET.get('q')
        if query_string:
            query = self._query_fields(query_string.split())
            results = self._to_json(self.model.objects.filter(query))
            return JsonResponse({'results': results})
        else:
            return JsonResponse({})


class ModelLookup(View):
    lookup_fields = []
    def _query_fields(self, terms):
        raise NotImplemented

    def _to_json(self, query):
        return list(query.values())

    def get(self, *args, **kwargs):
        fields = {}
        for field in self.lookup_fields:
            fields[field] = self.request.GET.get(field)
        if fields:
            query = self._query_fields(fields)
            if query is None:
                return JsonResponse({})
            results = self._to_json(self.model.objects.filter(query))
            return JsonResponse({'results': results})
        else:
            return JsonResponse({})


class PatronSearch(PatronSearchMixin, ModelSearch):
    model = Patron


class PatronLookup(PatronLookupMixin, ModelLookup):
    model = Patron
    lookup_fields = ['first_name', 'last_name', 'address_line1', 'address_line2', 'address_line3']


class AuctionItemSearch(AuctionItemSearchMixin, ModelSearch):
    model = AuctionItem


class SalesDashboard(TemplateView):

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['total_sales'] = Purchase.objects.all().aggregate(Sum('amount'))['amount__sum']

        return context


class Reports(GroupRequiredMixin, TemplateView):
    template_name = 'auction/reports.html'
    group_required = ['admins', 'account_managers']


class UnsettledAccounts(GroupRequiredMixin, TemplateView):
    template_name = 'auction/reports_unsettled_accounts.html'
    group_required = ['admins', 'account_managers']

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        patrons_with_purchases = Patron.objects.exclude(purchases__isnull=True).order_by('last_name')
        patrons_not_settled = [p for p in patrons_with_purchases if not p.account_is_settled]
        context['patrons'] = patrons_not_settled

        return context


class SalesByBooth(GroupRequiredMixin, TemplateView):
    template_name = 'auction/sales_by_booth.html'
    group_required = 'admins'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        # Summarize all the booth sales, except for the Auction booth, which we handle later
        booth_sales = Booth.objects.exclude(name="Auction").annotate(Sum('priceditem__purchase__amount'))
        booths = {}
        for b in booth_sales:
            amount = b.priceditem__purchase__amount__sum
            booths[b.name] = D(amount)

        # Auction Sales we gather directly
        for cat_name, cat_display in AuctionItem.CATEGORIES:
            auction_sales = AuctionItem.objects.filter(is_purchased=True, category=cat_name).aggregate(Sum('purchase__amount'))['purchase__amount__sum']
            booths['Auction: {}'.format(cat_display)] = D(auction_sales)

        # Donations without a recorded booth need to be accounted for too
        donations = PricedItem.objects.filter(booth__isnull=True).aggregate(Sum('purchase__amount'))['purchase__amount__sum']
        booths['Generic Donations'] = D(donations)

        # Fees
        fees = D(Fee.objects.all().aggregate(Sum('amount'))['amount__sum'])
        booths['Fees'] = fees

        total = D(Purchase.objects.all().aggregate(Sum('amount'))['amount__sum']) + fees
        context['total_sum'] = D(total)
        context['booth_sums'] = booths

        return context

