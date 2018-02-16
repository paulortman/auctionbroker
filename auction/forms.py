from decimal import Decimal
from django import forms

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
    amount = forms.DecimalField(max_digits=15, decimal_places=2, min_value=Decimal('0.0'))
    quantity = forms.IntegerField(min_value=0)

