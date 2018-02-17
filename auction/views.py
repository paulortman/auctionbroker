from django.core.exceptions import ValidationError
from django.forms import formset_factory
from django.shortcuts import render, redirect, get_object_or_404
from django.urls import reverse
from django.views import View
from django.views.generic import ListView, DetailView, UpdateView, CreateView, DeleteView, TemplateView, FormView
from djmoney.money import Money
from extra_views import FormSetView

from auction.modelfactory import BoothFactory
from .models import Item, Buyer, Purchase
from .forms import ItemForm, BuyerForm, PricedItemPurchaseForm, CheckoutBuyerForm, CheckoutPurchaseForm


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

    def form_valid(self, form):
        buyer_num = form.cleaned_data['buyer_num']
        try:
            buyer = Buyer.objects.get(buyer_num=buyer_num)
        except Buyer.DoesNotExist:
            form.add_error("Buyer {} unknown".format(buyer_num))
            redirect('checkout_buyer', buyer_num=buyer_num)

        return redirect('checkout_purchase', buyer_num=buyer.buyer_num)


class CheckoutPurchase(FormSetView):
    template_name = 'auction/checkout_purchase.html'
    form_class = CheckoutPurchaseForm

    def get_context_data(self, **kwargs):
        context = super(CheckoutPurchase, self).get_context_data(**kwargs)
        buyer = get_object_or_404(Buyer, buyer_num=self.kwargs.get('buyer_num'))
        context['buyer'] = buyer
        return context

    def formset_valid(self, formset):
        context = self.get_context_data()
        purchase_total = sum([form.entry_total for form in formset.forms])
        buyer = get_object_or_404(Buyer, buyer_num=self.kwargs.get('buyer_num'))

        # Commit the purchase
        p = Purchase.build_priced_item(buyer=buyer, amount=purchase_total, booth=BoothFactory())

        context['purchase_total'] = purchase_total
        return render(self.request, template_name='auction/checkout_complete.html', context=context)


class CheckoutComplete(TemplateView):
    template_name = 'auction/checkout_complete.html'
