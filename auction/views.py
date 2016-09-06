from django.views.generic import ListView, DetailView, UpdateView, CreateView, DeleteView

from .models import AuctionItem, Bidder
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
