from django import forms
from djmoney.forms import MoneyField

from .models import Item, Booth, Buyer, Payment


class ItemForm(forms.ModelForm):
    class Meta:
        model = Item
        exclude = []

class ItemBiddingForm(forms.Form):
    amount = MoneyField(max_digits=15, decimal_places=2, default_currency='USD')
    buyer_num = forms.CharField(max_length=10)


class BoothForm(forms.ModelForm):
    class Meta:
        model = Booth
        exclude = ['slug']


class PaymentForm(forms.ModelForm):
    class Meta:
        model = Payment
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
        if self.cleaned_data:
            return self.cleaned_data['amount'] * self.cleaned_data['quantity']
        return 0
    class Meta:
        model = Item
        include = []


class BoothForm(forms.ModelForm):
    class Meta:
        model = Booth
        exclude = ['slug']


class PaymentForm(forms.ModelForm):
    class Meta:
        model = Payment
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
        if self.cleaned_data:
            return self.cleaned_data['amount'] * self.cleaned_data['quantity']
        return 0
