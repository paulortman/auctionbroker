from django import forms
from django.forms import widgets, ModelChoiceField, formset_factory

from .models import Booth, Patron, Payment, buyer_number_validator, AuctionItem, Purchase
from .utils import multiple_buyer_number_parser


class PatronChoiceField(ModelChoiceField):
    def label_from_instance(self, obj):
        return "{last_name}, {first_name}".format(last_name=obj.last_name, first_name=obj.first_name)


class AuctionItemEditForm(forms.ModelForm):
    scheduled_sale_time = forms.SplitDateTimeField(widget=widgets.SplitDateTimeWidget,
                                                   help_text="Enter the scheduled date ('YYYY-MM-DD') and the time ('HH:MM PM')")
    donor = PatronChoiceField(queryset=Patron.objects.all().order_by('last_name'), required=False)

    class Meta:
        model = AuctionItem
        exclude = ['sale_time',]


class AuctionItemCreateForm(forms.ModelForm):
    scheduled_sale_time = forms.SplitDateTimeField(widget=widgets.SplitDateTimeWidget,
                                                   help_text="Enter the scheduled date ('YYYY-MM-DD') and the time ('HH:MM PM')")
    donor = PatronChoiceField(queryset=Patron.objects.all().order_by('last_name'), required=False)

    class Meta:
        model = AuctionItem
        exclude = ['is_purchased', 'sale_time']


class ItemBiddingForm(forms.Form):
    amount = forms.DecimalField(max_digits=15, decimal_places=2)
    buyer_num = forms.CharField(max_length=10, label="Buyer Number")
    quantity = forms.CharField(max_length=10, label="Quantity", required=False)

class ItemMultiBiddingForm(forms.Form):
    amount = forms.DecimalField(max_digits=15, decimal_places=2)
    buyer_numbers = forms.CharField(label="Buyer Numbers (comma or space separated)")
    quantity = forms.IntegerField(label="Quantity", required=False, initial=1)
    DELETE = forms.BooleanField(label="Delete?", required=False)

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.validated_buyer_numbers = []

    def clean(self):
        cleaned_data = super().clean()
        buyer_numbers = multiple_buyer_number_parser(cleaned_data.get('buyer_numbers', ''))
        for num in buyer_numbers:
            if not Patron.objects.filter(buyer_num=num).exists():
                raise forms.ValidationError("Buyer number {} is not a valid number".format(num))
            self.validated_buyer_numbers.append(num)


class BoothForm(forms.ModelForm):
    class Meta:
        model = Booth
        exclude = ['slug']


class PaymentForm(forms.ModelForm):
    class Meta:
        model = Payment
        exclude = []


class PurchaseEditForm(forms.Form):
    description = forms.CharField(max_length=100, required=False)
    amount = forms.DecimalField(max_digits=15, decimal_places=2)


class PurchaseForm(forms.ModelForm):
    class Meta:
        model = Purchase
        exclude = []


class PatronCreateForm(forms.ModelForm):

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
                                widget=widgets.TextInput(attrs={'autofocus': 'autofocus',
                                                                'pattern': '[0-9\.]*'}))



class CheckoutPurchaseForm(forms.Form):
    price = forms.DecimalField(max_digits=15, decimal_places=2,
                               widget=widgets.TextInput(attrs={'autofocus': 'autofocus',
                                                               'pattern': '[0-9\.]*'}))
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


class PatronPaymentCashForm(forms.Form):
    amount = forms.DecimalField(max_digits=15, decimal_places=2,
                                widget=widgets.TextInput(attrs={'autofocus': 'autofocus'}))
    method = forms.ChoiceField(choices=((Payment.CASH, 'Cash'), (Payment.CHECK, 'Check')), widget=widgets.RadioSelect())
    note = forms.CharField(max_length=50, label='Optional Descriptive Note', required=False,
                           help_text="Record check number or other details")


class PatronPaymentCCForm(forms.Form):
    amount = forms.DecimalField(max_digits=15, decimal_places=2,
                                widget=widgets.TextInput(attrs={'autofocus': 'autofocus'}))


class PatronPaymentCCFeeForm(forms.Form):
    ccfee = forms.DecimalField(max_digits=15, decimal_places=2, help_text="Credit Card Processing Fee",
                               label="Credit Card Fee", widget=widgets.TextInput(attrs={'autofocus': 'autofocus'}))
    note = forms.CharField(max_length=50, label='Optional Descriptive Note', required=False,
                           help_text="Record transaction ID or similar")


class DonateForm(forms.Form):
    buyer_num = forms.CharField(max_length=8, label='Buyer Number')
    donation = forms.DecimalField(max_digits=15, decimal_places=2, help_text="Enter Dollar Amount, ex. $100.00",
                                  widget=widgets.TextInput(attrs={'autofocus': 'autofocus'}))
    note = forms.CharField(max_length=50, label='Optional Descriptive Note', required=False)
    booth = forms.ModelChoiceField(queryset=Booth.objects.all(), required=False)


class PatronDonateForm(forms.Form):
    donation = forms.DecimalField(max_digits=15, decimal_places=2, help_text="Enter Dollar Amount, ex. $100.00",
                               widget=widgets.TextInput(attrs={'autofocus': 'autofocus'}))
    note = forms.CharField(max_length=50, label='Optional Descriptive Note', required=False)
    booth = forms.ModelChoiceField(queryset=Booth.objects.all(), required=False)



class CSVUploadForm(forms.Form):
    csvfile = forms.FileField(label='CSV file')
