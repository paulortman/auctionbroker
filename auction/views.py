from django.forms import formset_factory
from django.shortcuts import render
from django.views import View
from django.views.generic import ListView, DetailView, UpdateView, CreateView, DeleteView, TemplateView, FormView

from .models import Item, Buyer, Purchase
from .forms import ItemForm, BuyerForm, PricedItemPurchaseForm

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


class CheckoutBidder(FormView):
    template_name =


class CheckoutPurchase(FormView):
    pass


class CheckoutComplete(FormView):
    pass
