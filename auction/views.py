from django.views import View
from django.views.generic import ListView, DetailView, UpdateView, CreateView, DeleteView, TemplateView, FormView

from .models import Item, Buyer, Purchase
from .forms import ItemForm, BuyerForm

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
        c = Purchase.objects.create(bidder=b, amount='1')
        ai.charge = c
        ai.save()
        return super().get(request, args, kwargs)


class AddCharge(FormView):
    template_name = 'auction/add_charge.html'


