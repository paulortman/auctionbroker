from django.views import View
from django.views.generic import ListView, DetailView, UpdateView, CreateView, DeleteView, TemplateView

from .models import AuctionItem, Bidder, Charge
from .forms import AuctionItemForm, BidderForm

class AuctionItemList(ListView):
    model = AuctionItem


class AuctionItemDetail(DetailView):
    model = AuctionItem


class AuctionItemCreate(CreateView):
    model = AuctionItem
    form_class = AuctionItemForm


class AuctionItemUpdate(UpdateView):
    model = AuctionItem
    form_class = AuctionItemForm


class AuctionItemDelete(DeleteView):
    model = AuctionItem


class BidderList(ListView):
    model = Bidder


class BidderDetail(DetailView):
    model = Bidder


class BidderCreate(CreateView):
    model = Bidder
    form_class = BidderForm


class BidderUpdate(UpdateView):
    model = Bidder
    form_class = BidderForm


class BidderDelete(DeleteView):
    model = Bidder


class RandomSale(TemplateView):
    template_name = 'sale.html'
    def get(self, request, *args, **kwargs):
        from auction.modelfactory import AuctionItemFactory, BidderFactory
        b = BidderFactory.create()
        ai = AuctionItemFactory.create()
        c = Charge.objects.create(bidder=b, amount='1')
        ai.charge = c
        ai.save()
        return super().get(request, args, kwargs)

