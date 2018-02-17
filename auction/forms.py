from django import forms
from djmoney.forms import MoneyField

from .models import Item
from .models import Buyer


class ItemForm(forms.ModelForm):
    class Meta:
        model = Item
        exclude = []


class BuyerForm(forms.ModelForm):
    class Meta:
        model = Buyer
        exclude = []


class PricedItemPurchaseForm(forms.Form):
    amount = MoneyField(max_digits=15, decimal_places=2, default_currency='USD')
    quantity = forms.IntegerField(min_value=0)


class CheckoutBuyerForm(forms.Form):
    buyer_num = forms.CharField(max_length=10)

class CheckoutPurchaseForm(PricedItemPurchaseForm):
    amount = MoneyField(max_digits=15, decimal_places=2, default_currency='USD')
    quantity = forms.IntegerField(min_value=0)

    @property
    def entry_total(self):
        return self.cleaned_data['amount'] * self.cleaned_data['quantity']
