from braces.views import GroupRequiredMixin
from django.contrib import messages
from django.contrib.staticfiles import finders
from django.forms import formset_factory
from django.http import HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.template.loader import render_to_string
from django.urls import reverse
from django.views.generic import ListView, DetailView, UpdateView, CreateView, DeleteView, TemplateView, FormView
from extra_views import FormSetView
from weasyprint import HTML, CSS
from weasyprint.fonts import FontConfiguration

from .models import Item, Buyer, Purchase, Booth, Payment, AuctionItem, USD, D
from .forms import BuyerForm, PricedItemPurchaseForm, CheckoutBuyerForm, CheckoutPurchaseForm, BoothForm, \
    PaymentForm, ItemBiddingForm, CheckoutConfirmForm, AuctionItemForm, BuyerPaymentForm, PurchaseForm


class AuctionItemMixin:
    def get_queryset(self):
        return self.model.objects.all().order_by('sale_time','scheduled_sale_time')

    def get_object(self):
        item_number = self.kwargs.get('item_number', None)
        if not item_number:
            raise Exception("item_number not specified")
        return self.model.objects.get(item_number=item_number)

class AuctionItemList(AuctionItemMixin, ListView):
    model = AuctionItem

class AuctionItemManagement(AuctionItemMixin, ListView):
    model = AuctionItem
    template_name = 'auction/auctionitem_management.html'

    def get_queryset(self):
        qs = super().get_queryset()
        return qs.select_related('purchase', 'purchase__buyer')

class AuctionItemDetail(AuctionItemMixin, DetailView):
    model = AuctionItem


class AuctionItemCreate(AuctionItemMixin, CreateView):
    model = AuctionItem
    form_class = AuctionItemForm


class AuctionItemUpdate(AuctionItemMixin, UpdateView):
    model = AuctionItem
    form_class = AuctionItemForm


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


class PurchaseList(ListView):
    model = Purchase


class PurchaseDetail(DetailView):
    model = Purchase


class PurchaseCreate(CreateView):
    model = Purchase
    form_class = PurchaseForm


class PurchaseUpdate(UpdateView):
    model = Purchase
    form_class = PurchaseForm


class PurchaseDelete(DeleteView):
    template_name = 'auction/generic_confirm_delete.html'
    model = Purchase

    def get_success_url(self):
        buyer = self.get_object().buyer
        return reverse('buyer_detail', kwargs={'pk': buyer.pk})


class PaymentList(ListView):
    model = Payment


class PaymentDetail(DetailView):
    model = Payment


class PaymentCreate(CreateView):
    model = Payment
    form_class = PaymentForm


class PaymentUpdate(UpdateView):
    model = Payment
    form_class = PaymentForm


class PaymentDelete(DeleteView):
    template_name = 'auction/generic_confirm_delete.html'
    model = Payment

    def get_success_url(self):
        buyer = self.get_object().buyer
        return reverse('buyer_detail', kwargs={'pk': buyer.pk})


class BuyerMixin:
    model = Buyer
    def get_object(self):
        pk = self.kwargs.get('pk', None)
        if not pk:
            raise Exception("pk not specified")
        return self.model.objects.get(pk=pk)

class BuyerList(BuyerMixin, ListView):

    def get_queryset(self):
        qs = super().get_queryset()
        # return qs.select_related('payments', 'purchases')
        return qs.prefetch_related('payments', 'purchases')


class BuyerDetail(BuyerMixin, DetailView):
    pass


class BuyerCreate(BuyerMixin, CreateView):
    form_class = BuyerForm


class BuyerUpdate(BuyerMixin, UpdateView):
    form_class = BuyerForm


class BuyerDelete(BuyerMixin, DeleteView):
    template_name = 'auction/generic_confirm_delete.html'


class BuyerReceipt(BuyerMixin, DetailView):
    template_name = 'auction/buyer_receipt.html'

    def get(self, *args, **kwargs):
        context={'buyer': self.get_object()}
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
        response['Content-Disposition'] = 'filename="somefilename.pdf"'
        html.write_pdf(target=response, stylesheets=[css,], font_config=font_config)

        return response


class BuyerPay(BuyerMixin, FormView):
    form_class = BuyerPaymentForm
    template_name = 'auction/buyer_payment.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['buyer'] = self.get_object()
        return context

    def form_valid(self, form):
        buyer = self.get_object()
        amount = form.cleaned_data['amount']
        Payment.objects.create(buyer=buyer, amount=amount, method=form.cleaned_data['method'])
        msg = "Payment of {amount} made by {name}".format(amount=USD(amount), name=buyer.name)
        messages.add_message(self.request, messages.INFO, msg)
        return redirect('buyer_detail', pk=buyer.pk)


class RandomSale(TemplateView):
    template_name = 'sale.html'
    def get(self, request, *args, **kwargs):
        from auction.modelfactory import ItemFactory, BuyerFactory
        b = BuyerFactory.create()
        ai = ItemFactory.create()
        c = Purchase.objects.create(buyer=b, amount='1')
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


class CheckoutBuyer(FormView):
    template_name = 'auction/checkout_buyer.html'
    form_class = CheckoutBuyerForm

    def dispatch(self, request, *args, **kwargs):
        booth_slug = self.kwargs.get('booth_slug')
        self.booth = get_object_or_404(Booth, slug=booth_slug)
        return super(CheckoutBuyer, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(CheckoutBuyer, self).get_context_data(**kwargs)
        context['booth'] = self.booth
        return context

    def form_valid(self, form):
        buyer_num = form.cleaned_data['buyer_num']
        try:
            buyer = Buyer.objects.get(buyer_num=buyer_num)
        except Buyer.DoesNotExist:
            form.add_error('buyer_num', "Buyer {} unknown".format(buyer_num))
            return redirect('checkout_buyer', booth_slug=self.booth.slug)

        return redirect('checkout_purchase', buyer_num=buyer.buyer_num, booth_slug=self.booth.slug)


class CheckoutPurchase(FormSetView):
    template_name = 'auction/checkout_purchase.html'
    form_class = CheckoutPurchaseForm
    extra = 10

    def dispatch(self, request, *args, **kwargs):
        booth_slug = self.kwargs.get('booth_slug')
        buyer_num = self.kwargs.get('buyer_num')
        self.booth = get_object_or_404(Booth, slug=booth_slug)
        self.buyer = get_object_or_404(Buyer, buyer_num=buyer_num)
        return super(CheckoutPurchase, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(CheckoutPurchase, self).get_context_data(**kwargs)
        context['buyer'] = self.buyer
        context['booth'] = self.booth
        return context

    def formset_valid(self, formset):
        context = self.get_context_data()
        values = [form.serialize() for form in formset.forms if form.has_changed()]
        self.request.session['purchase_forms'] = values
        purchase_total = sum([form.entry_total for form in formset.forms])
        self.request.session['purchase_total'] = str(purchase_total)

        return redirect('checkout_confirm', buyer_num=self.buyer.buyer_num, booth_slug=self.booth.slug)


class CheckoutConfirm(FormView):
    form_class = CheckoutConfirmForm
    template_name = 'auction/checkout_confirm.html'

    def dispatch(self, request, *args, **kwargs):
        booth_slug = self.kwargs.get('booth_slug')
        buyer_num = self.kwargs.get('buyer_num')
        self.booth = get_object_or_404(Booth, slug=booth_slug)
        self.buyer = get_object_or_404(Buyer, buyer_num=buyer_num)
        return super(CheckoutConfirm, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(CheckoutConfirm, self).get_context_data(**kwargs)
        context['buyer'] = self.buyer
        context['booth'] = self.booth
        context['purchase_total'] = D(self.request.session['purchase_total'])
        return context

    def form_valid(self, form):
        purchase_total = D(self.request.session['purchase_total'])

        # Save the purchase for the buyer
        p = Purchase.create_priced_item(buyer=self.buyer, amount=purchase_total, booth=self.booth)

        # Clear the session state
        del(self.request.session['purchase_total'])
        del(self.request.session['purchase_forms'])

        msg = "Completed Purchase of {amount} by {name} ({number})".format(
            amount=USD(purchase_total), name=self.buyer.name, number=self.buyer.buyer_num)
        messages.add_message(self.request, messages.INFO, msg)

        return redirect('checkout_buyer', booth_slug=self.booth.slug)


class BiddingRecorder(FormView):
    model = Item
    form_class = ItemBiddingForm
    template_name = 'auction/bidding_recorder.html'

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
        buyer = get_object_or_404(Buyer, buyer_num=buyer_num)
        amount = form.cleaned_data['amount']
        purchase = Purchase.purchase_item(buyer=buyer, amount=amount, item=self.item)
        msg = "{b_num} ({b_name}) purchased {i_name} ({i_num}) in the amount of {amount}".format(
            b_num=buyer.buyer_num, b_name=buyer.name, i_name=self.item.name, i_num=self.item.item_number,
            amount=USD(amount))
        messages.add_message(self.request, messages.INFO, msg)
        return redirect('item_management')

