import csv
import decimal
import io

import xlsxwriter
from braces.views import GroupRequiredMixin, UserPassesTestMixin
from crispy_forms.bootstrap import PrependedText, AppendedText, StrictButton
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Submit, Field, Column, Row, Button
from django.conf import settings
from django.contrib import messages
from django.contrib.staticfiles import finders
from django.core.exceptions import ValidationError
from django.db.models import Q, Sum, Min
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

from .models import Patron, Purchase, Booth, Payment, AuctionItem, round_scheduled_sale_time, Fee
from auction.utils import D, USD, calc_cc_fee_amount
from .forms import PatronForm, PricedItemPurchaseForm, CheckoutPatronForm, CheckoutPurchaseForm, BoothForm, \
    PaymentForm, ItemBiddingForm, CheckoutConfirmForm, PurchaseForm, PatronCreateForm, \
    PatronDonateForm, AuctionItemEditForm, AuctionItemCreateForm, DonateForm, PatronPaymentCashForm, \
    PatronPaymentCCForm, PatronPaymentCCFeeForm, PurchaseEditForm, CSVUploadForm, ItemMultiBiddingForm


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

        booth_slug = self.kwargs.get('booth_slug', None)
        if booth_slug:
            qs = qs.filter(booth__slug=booth_slug)

        filter = self.request.GET.get('q')
        if filter:
            terms = filter.split()
            query = self._query_fields(terms)
            qs = qs.filter(query)

        return qs.select_related('donor')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        booth_slug = self.kwargs.get('booth_slug', None)
        if booth_slug:
            context['auction_booth'] = Booth.objects.get(slug=booth_slug)

        return context


class AuctionItemDetail(AuctionItemMixin, DetailView):
    model = AuctionItem


class AuctionItemCreate(AuctionItemMixin, CreateView):
    model = AuctionItem
    form_class = AuctionItemCreateForm

    def form_valid(self, form):
        booth_slug = self.kwargs.get('booth_slug', None)
        if booth_slug:
            form.instance.booth = Booth.objects.get(booth_slug=booth_slug)

        form.instance.save()
        i = form.instance
        msg = "Auction Item '{name}' ({num}) created successfully.".format(name=i.name, num=i.item_number)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')

        if 'save_and_add_another' in self.request.POST:
            return redirect('item_create')
        if 'save_and_return_to_list' in self.request.POST:
            return redirect('item_management', booth_slug=i.booth.slug)

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

        booth_slug = self.kwargs.get('booth_slug', None)
        if booth_slug:
            initial['booth'] = Booth.objects.get(booth_slug=booth_slug)

        return initial


class AuctionItemUpdate(AuctionItemMixin, UpdateView):
    model = AuctionItem
    form_class = AuctionItemEditForm

    def form_valid(self, form):
        if 'is_purchased' in form.changed_data and form.cleaned_data['is_purchased'] is False:
            raise Exception("Fix this")
            #form.instance.void_purchase()
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


class PatronJump(View):
    def get(self, *arg, **kwargs):
        try:
            lookup_num = self.request.GET['buyer_num']
        except KeyError:
            lookup_num = None

        if lookup_num:
            try:
                p = Patron.objects.get(buyer_num=lookup_num)
            except Patron.DoesNotExist:
                return redirect('patron_list')

            return redirect('patron_detail', pk=p.pk)

        else:
            return redirect('patron_list')


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
        p = Purchase.create_priced_purchase(patron=self.patron, amount=purchase_total, booth=self.booth)

        # Clear the session state
        del(self.request.session['purchase_total'])
        del(self.request.session['purchase_forms'])

        msg = "Completed Purchase of {amount} by {name} ({number})".format(
            amount=USD(purchase_total), name=self.patron.name, number=self.patron.buyer_num)
        messages.add_message(self.request, messages.INFO, msg, 'alert-success')

        return redirect('checkout_patron', booth_slug=self.booth.slug)


class BiddingRecorderFormHelper(FormHelper):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.form_method = 'post'
        self.layout = Layout(
            Row(
                Column(PrependedText('amount', '$'), css_class="form-group col-md-2 mb-0"),
                Column('buyer_numbers', css_class="form-group col-md-8 mb-0"),
                Column('quantity', css_class="form-group col-md-1 mb-0"),
                Column('DELETE', css_class="form-group col-md-1 mb-0"),
                css_class='form-row'
            ),
        )
        self.render_required_fields = True

        self.add_input(Button("add", value="Add Another Entry", css_id="add_more", css_class='btn-outline-primary'))
        self.add_input(Submit("submit", "Record Bid"))
        self.add_input(Submit("cancel", "Cancel", css_class='btn-secondary'))


class BiddingRecorder(GroupRequiredMixin, FormSetView):
    group_required = 'auction_managers'
    template_name = 'auction/bidding_recorder.html'
    form_class = ItemMultiBiddingForm
    factory_kwargs = {
        'extra': 2,
        'can_delete': True,
    }

    def get_initial(self):
        # We could use StingAgg() and grouping by amount and quantity to condense this back into CSV bidder numbers
        item = self.get_item()
        initial = [{'buyer_numbers': p.patron.buyer_num,
                    'amount': p.amount,
                    'quantity': p.quantity} for p in item.purchase_set.all().order_by('amount')]
        return initial

    def get_item(self):
        item_number = self.kwargs.get('item_number')
        return get_object_or_404(AuctionItem, item_number=item_number)

    def get_context_data(self, **kwargs):
        context = super(BiddingRecorder, self).get_context_data(**kwargs)
        context['item'] = self.get_item()
        context['helper'] = BiddingRecorderFormHelper()
        return context

    def formset_valid(self, formset):
        # This simplest thing to do is delete all the bids previously recorded and then create new bids with the bids
        # given here.  We assume this list is authoritative.
        item = self.get_item()
        item.purchase_set.all().delete()
        for form in formset.forms:
            if form.is_valid() and form.cleaned_data:
                buyer_numbers = [x.strip() for x in form.cleaned_data['buyer_numbers'].split(',')]
                for buyer_num in buyer_numbers:
                    patron = get_object_or_404(Patron, buyer_num=buyer_num)
                    amount = form.cleaned_data['amount']
                    quantity = form.cleaned_data['quantity']
                    if not form.cleaned_data['DELETE']:  # we've already deleted it, so we just don't add it back
                        Purchase.create_auction_item_purchase(patron=patron, amount=amount,
                                                              auction_item=item, quantity=quantity)
                        msg = "{b_num} ({b_name}) purchased {i_name} ({i_num}) in the amount of {amount}".format(
                            b_num=patron.buyer_num, b_name=patron.name, i_name=item.name, i_num=item.item_number,
                            amount=USD(amount))
                        messages.add_message(self.request, messages.INFO, msg, 'alert-success')
        return redirect('item_management', booth_slug=item.booth.slug)


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

        # Summarize all the booth sales
        booth_sales = Booth.objects.annotate(Sum('purchase__amount')).order_by('category', 'name')
        booths = {}
        for b in booth_sales:
            amount = b.purchase__amount__sum
            booths[b.name] = D(amount)

        # Donations without a recorded booth need to be accounted for too
        donations = Purchase.objects.filter(booth__isnull=True).aggregate(Sum('amount'))['amount__sum']
        booths['Generic Donations'] = D(donations)

        # Fees
        fees = D(Fee.objects.all().aggregate(Sum('amount'))['amount__sum'])
        booths['Fees'] = fees

        total = D(Purchase.objects.all().aggregate(Sum('amount'))['amount__sum']) + fees
        context['total_sum'] = D(total)
        context['booth_sums'] = booths

        return context


class AllSales(GroupRequiredMixin, View):
    group_required = 'admins'

    def get(self, *args, **kwargs):
        output = io.BytesIO()
        workbook = xlsxwriter.Workbook(output, {'remove_timezone': True})
        worksheet = workbook.add_worksheet()
        row = 0
        col = 0

        date_format = workbook.add_format({'num_format': 0x16})
        money_format = workbook.add_format({'num_format': 0x08})

        purchases = Purchase.objects.all().select_related('patron').order_by('mtime')
        # purchases = purchases.filter(Q(auctionitem__isnull=False) |
        #                             (Q(priceditem__isnull=False) & Q(priceditem__booth__isnull=True)))

        # write header
        worksheet.write(row, col+0, 'Last Name')
        worksheet.write(row, col+1, 'First Name')
        worksheet.write(row, col+2, 'Buyer Number')
        worksheet.write(row, col+3, 'Amount')
        worksheet.write(row, col+4, 'Transaction Time')
        worksheet.write(row, col+5, 'DB Time')
        worksheet.write(row, col+6, 'Item Number')
        worksheet.write(row, col+7, 'Item Name')
        worksheet.write(row, col+8, 'Booth')
        row = row + 1


        # data
        for purchase in purchases:
            worksheet.write(row, col+0, purchase.patron.last_name)
            worksheet.write(row, col+1, purchase.patron.first_name)
            worksheet.write(row, col+2, purchase.patron.buyer_num)
            worksheet.write(row, col+3, purchase.amount, money_format)
            worksheet.write(row, col+4, purchase.transaction_time, date_format)
            worksheet.write(row, col+5, purchase.ctime, date_format)
            worksheet.write(row, col+6, purchase.auction_item.item_number if purchase.auction_item else '')
            worksheet.write(row, col+7, purchase.auction_item.name if purchase.auction_item else '')
            worksheet.write(row, col+8, purchase.booth.name if purchase.booth else '')
            row = row + 1

        # Set colunn width
        worksheet.set_column(0, 1, 16)
        worksheet.set_column(2, 2, 4)
        worksheet.set_column(3, 5, 14)
        worksheet.set_column(6, 6, 4)
        worksheet.set_column(7, 8, 30)

        workbook.close()

        response = HttpResponse(output.getvalue(), content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        response['Content-Disposition'] = 'attachment; filename=All_Sales_Report.xlsx'

        return response


class PopulateAttendees(GroupRequiredMixin, FormView):
    group_required = 'admins'
    form_class = CSVUploadForm
    template_name = 'setup/populate_attendees.html'
    success_url = reverse_lazy('setup_success')

    def _decode_utf8(self, input_iterator):
        for l in input_iterator:
            yield l.decode('utf-8')

    def form_valid(self, form):
        csvfile = self.request.FILES['csvfile']
        reader = csv.DictReader(self._decode_utf8(csvfile))
        for row in reader:
            Patron.objects.create(first_name = row['First_Name'],
                                  last_name = row['Last_Name'],
                                  email = row['Email'],
                                  address_line1 = row['Address1'],
                                  address_line2 = row['Address2'],
                                  address_line3 = row['Address3'],
                                  phone1 = row['Phone'])

        return super().form_valid(form)


class PopulateAuctionItems(GroupRequiredMixin, FormView):
    group_required = 'admins'
    form_class = CSVUploadForm
    template_name = 'setup/populate_auctionitems.html'
    success_url = reverse_lazy('setup_success')

    def _decode_utf8(self, input_iterator):
        for l in input_iterator:
            yield l.decode('utf-8')

    def form_valid(self, form):
        csvfile = self.request.FILES['csvfile']
        # with open('sale_items.csv', newline='', encoding='utf-8-sig') as csvfile:
        csv.register_dialect('our_tsv', delimiter='\t', skipinitialspace=True)
        reader = csv.reader(self._decode_utf8(csvfile), dialect='our_tsv')

        for i in AuctionItem.objects.filter(category=AuctionItem.MAIN):
            i.delete()

        auction = Booth.objects.get(name='Auction')
        for row in reader:
            rawtime, title, description = row[0], row[1], row[2]
            hour, minute = rawtime.split(':')
            hour, minute = int(hour), int(minute)
            if hour < 12:
                hour = hour + 12
            item_number = "{:02d}{:02d}".format(hour, minute)
            time = self.dt.replace(hour=hour, minute=minute)
            print (time.strftime('%c %Z'))
            AuctionItem.objects.create(booth=auction,
                                       name=title,
                                       scheduled_sale_time=timezone.make_aware(time, settings.SALE_TZ),
                                       item_number=item_number,
                                       long_desc=description,
                                       category=AuctionItem.MAIN)

        return super().form_valid(form)
