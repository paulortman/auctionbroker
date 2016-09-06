from django import forms

from .models import AuctionItem
from .models import Bidder


class AuctionItemForm(forms.ModelForm):
    class Meta:
        model = AuctionItem
        exclude = []


class BidderForm(forms.ModelForm):
    class Meta:
        model = Bidder
        exclude = []
