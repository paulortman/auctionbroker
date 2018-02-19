from braces.views import GroupRequiredMixin
from django.contrib import messages
from django.forms import formset_factory
from django.http import HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.template.loader import render_to_string
from django.views.generic import ListView, DetailView, UpdateView, CreateView, DeleteView, TemplateView, FormView
from djmoney.money import Money
from extra_views import FormSetView
from weasyprint import HTML, CSS
from weasyprint.fonts import FontConfiguration

from .models import Item, Buyer, Purchase, Booth, Payment
from .forms import ItemForm, BuyerForm, PricedItemPurchaseForm, CheckoutBuyerForm, CheckoutPurchaseForm, BoothForm, \
    PaymentForm, ItemBiddingForm, CheckoutConfirmForm


class ItemList(ListView):
    model = Item


class ItemDetail(DetailView):
    model = Item


class ItemCreate(CreateView):
    model = Item
    form_class = ItemForm


class ItemUpdate(UpdateView):
    model = Item
    form_class = ItemForm


class ItemDelete(DeleteView):
    model = Item


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
    model = Booth
    group_required = u'admins'


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
    model = Payment


class BuyerList(ListView):
    model = Buyer


class BuyerDetail(DetailView):
    model = Buyer


class BuyerCreate(CreateView):
    model = Buyer
    form_class = BuyerForm


class BuyerUpdate(UpdateView):
    model = Buyer
    form_class = BuyerForm


class BuyerDelete(DeleteView):
    model = Buyer

class BuyerReceipt(DetailView):
    template_name = 'auction/buyer_receipt.html'
    model = Buyer

    def get(self, *args, **kwargs):
        context={'buyer': self.get_object()}
        font_config = FontConfiguration()
        html = HTML(string=render_to_string(self.template_name, context=context))
        css = CSS(string="body { background-color: blue; }")

        # Create a PDF response and use Weasy to print to it
        response = HttpResponse(content_type="application/pdf")
        response['Content-Disposition'] = 'filename="somefilename.pdf"'
        html.write_pdf(target=response, stylesheets=[css,], font_config=font_config)

        return response


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
        values = [{'price': money_serialize(form.cleaned_data['price']), 'quantity': form.cleaned_data['quantity'] } for form in formset.forms]
        self.request.session['purchase_forms'] = values
        purchase_total = sum([form.entry_total for form in formset.forms])
        self.request.session['purchase_total'] = money_serialize(purchase_total)

        return redirect('checkout_confirm', buyer_num=self.buyer.buyer_num, booth_slug=self.booth.slug)


def money_serialize(money):
    return {'price': str(money.amount),
            'currency': str(money.currency)}

def money_deserialize(d):
    return Money(d['price'], d['currency'])


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
        context['purchase_total'] = money_deserialize(self.request.session['purchase_total'])
        return context

    def form_valid(self, form):
        purchase_total = money_deserialize(self.request.session['purchase_total'])

        # Save the purchase for the buyer
        p = Purchase.create_priced_item(buyer=self.buyer, amount=purchase_total, booth=self.booth)

        # Clear the session state
        del(self.request.session['purchase_total'])
        del(self.request.session['purchase_forms'])

        return redirect('checkout_buyer', booth_slug=self.booth.slug)


class BiddingRecorder(FormView):
    model = Item
    form_class = ItemBiddingForm
    template_name = 'auction/bidding_recorder.html'

    def dispatch(self, request, *args, **kwargs):
        item_pk = self.kwargs.get('item_pk')
        self.item = get_object_or_404(Item, pk=item_pk)
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
        msg = f"{buyer.buyer_num} ({buyer.name}) purchased {self.item.name} ({self.item.id}) in the amount of {amount}"
        messages.add_message(self.request, messages.INFO, msg)
        return redirect('bidding_list')

class BiddingList(ListView):
    model = Item
    template_name = 'auction/bidding_complete.html'

    # def get_context_data(self, **kwargs):
    #     context = super(BiddingList, self).get_context_data(**kwargs)
    #     last_purchase = self.kwargs.get('last_purchase', None)
    #     if last_purchase:
    #         context['last_purchase'] = last_purchase
    #     return context
    #
    #
    #

