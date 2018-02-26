from django import forms

from .models import Item, Booth, Buyer, Payment, buyer_number_validator, AuctionItem, Purchase


class AuctionItemForm(forms.ModelForm):
    class Meta:
        model = AuctionItem
        exclude = ['purchase']

class ItemBiddingForm(forms.Form):
    amount = forms.DecimalField(max_digits=15, decimal_places=2)
    buyer_num = forms.CharField(max_length=10)


class BoothForm(forms.ModelForm):
    class Meta:
        model = Booth
        exclude = ['slug']


class PaymentForm(forms.ModelForm):
    class Meta:
        model = Payment
        exclude = []


class PurchaseForm(forms.ModelForm):
    class Meta:
        model = Purchase
        exclude = []


class BuyerForm(forms.ModelForm):
    class Meta:
        model = Buyer
        exclude = []


class PricedItemPurchaseForm(forms.Form):
    amount = forms.DecimalField(max_digits=15, decimal_places=2)
    quantity = forms.IntegerField(min_value=0)


class CheckoutBuyerForm(forms.Form):
    buyer_num = forms.CharField(max_length=10,
                                validators=[buyer_number_validator],
                                label="Enter Buyer Number",
                                help_text="Enter the Buyer's Purchase number to start the checkout.",
                                widget=forms.TextInput(attrs={'autofocus': 'autofocus'}))



class CheckoutPurchaseForm(forms.Form):
    price = forms.DecimalField(max_digits=15, decimal_places=2,
                               widget=forms.TextInput(attrs={'autofocus': 'autofocu'}))
    quantity = forms.IntegerField(min_value=0, required=False)

    @property
    def entry_total(self):
        if self.cleaned_data:
            return self.cleaned_data['price'] * self.cleaned_data['quantity']
        return 0

    def clean_quantity(self):
        quantity = self.cleaned_data['quantity']
        if quantity is None or quantity == '':
            quantity = 1
        return quantity


    def serialize(self):
        return {'price': str(self.cleaned_data['price']), 'quantity': self.cleaned_data['quantity']}


class CheckoutConfirmForm(forms.Form):
    pass


class BuyerPaymentForm(forms.ModelForm):
    class Meta:
        model = Payment
        exclude = ['buyer', 'transaction_time']
