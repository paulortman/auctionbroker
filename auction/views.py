import json

from braces.views import GroupRequiredMixin, UserPassesTestMixin
from django.conf import settings
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth.views import LoginView
from django.contrib.staticfiles import finders
from django.core.exceptions import ValidationError
from django.db.models import Q
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

from .models import Item, Patron, Purchase, Booth, Payment, AuctionItem, USD, D, buyer_number_generator, \
    round_scheduled_sale_time, Fee
from .forms import PatronForm, PricedItemPurchaseForm, CheckoutPatronForm, CheckoutPurchaseForm, BoothForm, \
    PaymentForm, ItemBiddingForm, CheckoutConfirmForm, PatronPaymentForm, PurchaseForm, PatronCreateForm, \
    PatronDonateForm, AuctionItemEditForm, AuctionItemCreateForm, DonateForm


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

        filter = self.request.GET.get('q')
        if filter:
            terms = filter.split()
            query = self._query_fields(terms)
            qs = qs.filter(query)

        return qs.select_related('purchase', 'purchase__patron')


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
            return redirect('item_management')

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


class PurchaseUpdate(HonorNextMixin, UpdateView):
    model = Purchase
    form_class = PurchaseForm
    group_required = u'account_managers'
    raise_exception = True

    def form_valid(self, form):
        # Priced items are an unuusal case, we ned to adjust the FMV so that editing a price paid doesn't end up
        # creating a donation or negative donations.
        if 'amount' in form.changed_data and hasattr(form.instance, 'priceditem'):
            form.instance.priceditem.fair_market_value = form.cleaned_data['amount']
            form.instance.priceditem.save()
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


class PatronCreate(PatronMixin, CreateView):
    form_class = PatronCreateForm

    def form_valid(self, form):
        form.instance.buyer_num = buyer_number_generator()

        msg = "Patron '{name}' ({num}) created successfully.".format(name=form.instance.name, num=form.instance.buyer_num)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')

        if 'save_and_add_another' in self.request.POST:
            return redirect('patron_create')
        if 'save_and_return_to_list' in self.request.POST:
            return redirect('buyder_list')

        return super().form_valid(form)


class PatronUpdate(PatronMixin, UpdateView):
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


class PatronPay(PatronMixin, FormView):
    form_class = PatronPaymentForm
    template_name = 'auction/patron_payment.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['patron'] = self.get_object()
        return context

    def form_valid(self, form):
        patron = self.get_object()
        amount = form.cleaned_data['amount']
        Payment.objects.create(patron=patron, amount=amount,
                               method=form.cleaned_data['method'],
                               note=form.cleaned_data['note'])

        msg = "Payment of {amount} made by {name}".format(amount=USD(amount), name=patron.name)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')

        return redirect('patron_detail', pk=patron.pk)


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
        Purchase.create_donation(patron=patron, amount=amount, booth=None)

        msg = "Doncation of {amount} made by {name}".format(amount=USD(amount), name=patron.name)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')
        return redirect('patron_detail', pk=patron.pk)


class Donate(HonorNextMixin, FormView):
    form_class = DonateForm
    template_name = 'auction/donate.html'
    success_url = reverse_lazy('home')

    def form_valid(self, form):
        buyer_num = form.cleaned_data['buyer_num']
        amount = form.cleaned_data['donation']
        try:
            patron = Patron.objects.get(buyer_num=buyer_num)
        except Patron.DoesNotExist:
            raise ValidationError("Invalid Patron Number -- no patron exists")

        Purchase.create_donation(patron=patron, amount=amount, booth=None)

        msg = "Doncation of {amount} made by {name}".format(amount=USD(amount), name=patron.name)
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
    extra = 10

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
        purchase = Purchase.purchase_item(patron=patron, amount=amount, item=self.item)
        msg = "{b_num} ({b_name}) purchased {i_name} ({i_num}) in the amount of {amount}".format(
            b_num=patron.buyer_num, b_name=patron.name, i_name=self.item.name, i_num=self.item.item_number,
            amount=USD(amount))
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')
        return redirect('item_management')



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


class PatronSearch(PatronSearchMixin, ModelSearch):
    model = Patron


class AuctionItemSearch(AuctionItemSearchMixin, ModelSearch):
    model = AuctionItem

