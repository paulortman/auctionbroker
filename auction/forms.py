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
