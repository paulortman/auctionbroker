from django import forms
from django.forms import widgets, ModelChoiceField

from .models import Booth, Patron, Payment, buyer_number_validator, AuctionItem, Purchase


class PatronChoiceField(ModelChoiceField):
    def label_from_instance(self, obj):
        return "{last_name}, {first_name}".format(last_name=obj.last_name, first_name=obj.first_name)


class AuctionItemEditForm(forms.ModelForm):
    scheduled_sale_time = forms.SplitDateTimeField(widget=widgets.SplitDateTimeWidget,
                                                   help_text="Enter the scheduled date ('YYYY-MM-DD') and the time ('HH:MM PM')")
    donor = PatronChoiceField(queryset=Patron.objects.all().order_by('last_name'), required=False)

    class Meta:
        model = AuctionItem
        exclude = ['purchase', 'booth']


class AuctionItemCreateForm(forms.ModelForm):
    scheduled_sale_time = forms.SplitDateTimeField(widget=widgets.SplitDateTimeWidget,
                                                   help_text="Enter the scheduled date ('YYYY-MM-DD') and the time ('HH:MM PM')")
    donor = PatronChoiceField(queryset=Patron.objects.all().order_by('last_name'), required=False)

    class Meta:
        model = AuctionItem
        exclude = ['purchase', 'booth', 'is_purchased', 'sale_time']


class ItemBiddingForm(forms.Form):
    amount = forms.DecimalField(max_digits=15, decimal_places=2, help_text="Dollar amount, e.g. 10.00")
    buyer_num = forms.CharField(max_length=10, label="Buyer Number")


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


class PatronCreateForm(forms.ModelForm):
    buyer_num = forms.CharField(max_length=8, required=False, widget=widgets.HiddenInput)

    class Meta:
        model = Patron
        exclude = []
        widgets = {
            'first_name': widgets.TextInput(attrs={'autofocus': 'autofocus'})
        }

class PatronForm(forms.ModelForm):
    class Meta:
        model = Patron
        exclude = []


class PricedItemPurchaseForm(forms.Form):
    amount = forms.DecimalField(max_digits=15, decimal_places=2)
    quantity = forms.IntegerField(min_value=0)


class CheckoutPatronForm(forms.Form):
    buyer_num = forms.CharField(max_length=10,
                                validators=[buyer_number_validator],
                                label="Enter Buyer Number",
                                help_text="Enter the Patron's Buyer number to start the checkout.",
                                widget=widgets.TextInput(attrs={'autofocus': 'autofocus'}))



class CheckoutPurchaseForm(forms.Form):
    price = forms.DecimalField(max_digits=15, decimal_places=2,
                               widget=widgets.TextInput(attrs={'autofocus': 'autofocu'}))
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


class PatronPaymentForm(forms.ModelForm):

    class Meta:
        model = Payment
        exclude = ['patron', 'transaction_time']
        widgets = {'method': widgets.RadioSelect(),}


class DonateForm(forms.Form):
    buyer_num = forms.CharField(max_length=8, label='Buyer Number')
    donation = forms.DecimalField(max_digits=15, decimal_places=2, help_text="Enter Dollar Amount, ex. $100.00",
                                  widget=widgets.TextInput(attrs={'autofocus': 'autofocu'}))


class PatronDonateForm(forms.Form):
    donation = forms.DecimalField(max_digits=15, decimal_places=2, help_text="Enter Dollar Amount, ex. $100.00",
                               widget=widgets.TextInput(attrs={'autofocus': 'autofocu'}))


