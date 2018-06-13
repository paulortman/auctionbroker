import decimal

from django.core.exceptions import ValidationError
from django.db import models
from django.db.models import Max
from django.conf import settings
from django.utils import timezone
from django.shortcuts import reverse
from django.utils.text import slugify


def D(val):
    if val is None:
        return decimal.Decimal(0)
    return decimal.Decimal(val)


def USD(d):
    return "${}".format(d.quantize(decimal.Decimal('.01'), decimal.ROUND_HALF_UP))


class TrackedModel(models.Model):
    class Meta:
        abstract = True

    ctime = models.DateTimeField(auto_now_add=True)
    mtime = models.DateTimeField(auto_now=True)


class Item(models.Model):
    class Meta:
        abstract = True

    name = models.CharField(max_length=50, blank=False, help_text="Short but descriptive name of item.")
    long_desc = models.TextField(blank=True, verbose_name="Long Description",
                                 help_text="Enter a description, donor information, etc.")
    purchase = models.OneToOneField('Purchase', blank=True, null=True, on_delete=models.SET_NULL)
    booth = models.ForeignKey('Booth', blank=True, null=True, on_delete=models.SET_NULL)
    sale_time = models.DateTimeField(blank=True, null=True, verbose_name="Sale Time",
                                     help_text="When the item sold. Leave blank when creating")
    fair_market_value = models.DecimalField(max_digits=15, decimal_places=2, default=D(0),
                                            verbose_name="Fair Market Value (FMV)", help_text="Dollars, e.g. 10.00")
    is_purchased = models.BooleanField(default=False,
                                       help_text="Un-checking this item will delete and void the purchase")

    def __str__(self):
        return "({}) {}{}".format(self.id, self.name, "*" if self.purchase else "")

    def commit_to_purchase(self, purchase):
        self.purchase = purchase
        self.sale_time = timezone.now()
        self.is_purchased = True
        self.save()

    def void_purchase(self):
        if self.purchase:
            self.purchase.delete()
            self.purchase = None
        self.sale_time = None
        self.is_purchased = False
        self.save()

    @property
    def donation_amount(self):
        if self.purchase:
            return self.purchase.donation_amount
        return None


class PricedItem(TrackedModel, Item):
    pass


def item_number_generator():
    try:
        value = AuctionItem.objects.all().aggregate(Max('item_number'))['item_number__max']
    except AuctionItem.DoesNotExist:
        value = 0
    value = 0 if value is None else value
    return max([value, settings.BASE_AUCTION_NUMBER]) + 1


def round_scheduled_sale_time(dt):
    discard = timezone.timedelta(minutes=dt.minute % settings.AUCTIONITEM_SCHEDULED_TIME_INCREMENT,
                                 seconds=dt.second,
                                 microseconds=dt.microsecond)
    dt -= discard
    half = settings.AUCTIONITEM_SCHEDULED_TIME_INCREMENT / 2.0
    if discard >= timezone.timedelta(minutes=half):
        dt += timezone.timedelta(minutes=settings.AUCTIONITEM_SCHEDULED_TIME_INCREMENT)
    return dt


class AuctionItem(TrackedModel, Item):
    class Meta:
        pass

    item_number = models.PositiveIntegerField(unique=True, db_index=True, default=item_number_generator,
                                              help_text="Leave blank to auto-generate.")
    scheduled_sale_time = models.DateTimeField(blank=True, null=True, verbose_name="Scheduled Sale Time",
                                               help_text="The time when the item is scheduled during the auction.")
    donor_display = models.CharField(max_length=50, blank=True, null=True, verbose_name="Displayed Donor Name",
                                     help_text="How the item's donor would be displayed to the public")
    donor = models.ForeignKey('Patron', null=True, blank=True, help_text="The patron/donor for tax receipt purposes.",
                              related_name="donations", on_delete=models.SET_NULL)

    def get_absolute_url(self):
        return reverse('item_detail', kwargs={'item_number': self.item_number})


class AuctionItemImage(models.Model):
    class Meta:
        unique_together = ['item', 'sort_order']

    item = models.ForeignKey(AuctionItem, related_name="images", on_delete=models.CASCADE)
    image = models.ImageField()
    sort_order = models.PositiveIntegerField(default=1)


# @receiver(post_save, sender=AuctionItem)
# def send_sale_event(sender, instance, **kwargs):
#     if instance.purchase_id:
#         channel_layer = get_channel_layer()
#         async_to_sync(channel_layer.group_send)("sales", {
#             "type": "sales.message",
#             "text": json.dumps({
#                 'id': instance.id,
#                 'name': instance.name,
#                 'purchase_id': instance.purchase_id
#             })
#         })
#         print("Auction Sales Event")
#
# @receiver(post_save, sender=PricedItem)
# def send_sale_event(sender, instance, **kwargs):
#     if instance.purchase_id:
#         channel_layer = get_channel_layer()
#         async_to_sync(channel_layer.group_send)("sales", {
#             "type": "sales.message",
#             "text": json.dumps({
#                 'id': instance.id,
#                 'name': instance.name,
#                 'purchase_id': instance.purchase_id
#             })
#         })
#         print("Priced Item Event")

def buyer_number_generator():
    max_num = Patron.objects.aggregate(Max('buyer_num'))['buyer_num__max']
    max_num = int(max_num if max_num else 0)
    return max(max_num + 1, settings.BASE_BUYER_NUMBER)


class Patron(TrackedModel, models.Model):

    buyer_num = models.CharField(max_length=8, unique=True, db_index=True, verbose_name="Patron Number")
    first_name = models.CharField(max_length=30, verbose_name="First Name")
    last_name = models.CharField(max_length=30, verbose_name="Last Name")
    email = models.EmailField(blank=True, verbose_name="Email Address")
    address_line1 = models.CharField(max_length=50, verbose_name="Address")
    address_line2 = models.CharField(blank=True, max_length=50, verbose_name="Address Line 2, e.g. Marion, SD")
    address_line3 = models.CharField(blank=True, max_length=50, verbose_name="Address Line 3, e.g. 57043")
    phone1 = models.CharField(blank=True, max_length=20)

    def __str__(self):
        return "Patron {name} ({number})".format(name=self.name, number=self.buyer_num)

    def get_absolute_url(self):
        return reverse('patron_detail', kwargs={'pk': self.pk})

    @property
    def name(self):
        return "{} {}".format(self.first_name, self.last_name)

    @property
    def outstanding_purchases_total(self):
        s = self.purchases.aggregate(models.Sum('amount'))['amount__sum']
        return D(s)

    @property
    def purchases_total(self):
        purchases = self.purchases.all().aggregate(models.Sum('amount'))['amount__sum']
        return D(purchases)

    @property
    def payments_total(self):
        payments = self.payments.all().aggregate(models.Sum('amount'))['amount__sum']
        return D(payments)

    @property
    def in_kind_donations_total(self):
        return sum([i.fair_market_value for i in self.donations.all()])

    @property
    def in_kind_donations_sales_total(self):
        return sum([i.purchase.amount for i in self.donations.all()])

    @property
    def purchase_donations_total(self):
        return sum([p.donation_amount for p in self.purchases.all()])

    @property
    def donations_total(self):
        return self.purchase_donations_total + self.in_kind_donations_total

    @property
    def outstanding_balance(self):
        return self.purchases_total + self.fees_total - self.payments_total

    @property
    def outstanding_balance_no_fees(self):
        return self.purchases_total - self.payments_total

    @property
    def account_is_settled(self):
        return self.outstanding_balance == D(0)

    @property
    def fees_total(self):
        fees = self.fees.all().aggregate(models.Sum('amount'))['amount__sum']
        return D(fees)

    def apply_cc_usage_fee(self):
        cc_fee = self.get_cc_usage_fee()
        percent = settings.CC_TRANSACTION_FEE_PERCENTAGE * 100
        f = Fee.objects.create(patron=self, amount=cc_fee, description='Credit Card Fee ({}%)'.format(percent))
        return f

    def get_cc_usage_fee(self):
        cc_fee = self.outstanding_balance_no_fees * decimal.Decimal(settings.CC_TRANSACTION_FEE_PERCENTAGE)
        return cc_fee


def buyer_number_validator(value):
    try:
        buyer_num = int(value)
    except ValueError:
        raise ValidationError("'%(value)s' is not a valid Patron Number", params={'value': value})

    try:
        Patron.objects.get(buyer_num=buyer_num)
    except Patron.DoesNotExist:
        raise ValidationError("No patron exists for buyer number '%(value)s'", params={'value': value})


class Payment(TrackedModel, models.Model):
    CASH = 'CASH'
    CHECK = 'CHECK'
    CARD = 'CARD'
    METHODS = (
        (CASH, 'Cash'),
        (CHECK, 'Check'),
        (CARD, 'Card')
    )
    patron = models.ForeignKey(Patron, related_name='payments', on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=15, decimal_places=2)
    method = models.CharField(choices=METHODS, default='CHECK', max_length=6,
                              help_text="The method or type of payment made.")
    transaction_time = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    note = models.TextField(blank=True, help_text="Record any notes about the payment.")

    def __str__(self):
        return "{amount} payment by {patron}".format(amount=USD(self.amount), patron=self.patron.name)

    def get_absolute_url(self):
        return reverse('payment_detail', kwargs={'pk': self.pk})


class Fee(TrackedModel, models.Model):
    patron = models.ForeignKey(Patron, related_name='fees', on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=15, decimal_places=2)
    description = models.CharField(max_length=100)

    def __str__(self):
        return "{amount} fee paid by {patron}".format(amount=USD(self.amount), patron=self.patron.name)


class Purchase(TrackedModel, models.Model):
    patron = models.ForeignKey(Patron, related_name='purchases', on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=15, decimal_places=2)
    transaction_time = models.DateTimeField(auto_now_add=True, blank=True, null=True)

    def __str__(self):
        return "{amount} purchase by {patron}".format(amount=USD(self.amount), patron=self.patron.name)

    def get_absolute_url(self):
        return reverse('purchase_detail', kwargs={'pk': self.pk})

    @property
    def item(self):
        if hasattr(self, 'priceditem'):
            return self.priceditem
        if hasattr(self, 'auctionitem'):
            return self.auctionitem

        raise AttributeError('Purchase object has no valid \'item\' attribute')

    @property
    def donation_amount(self):
        return D(max(self.amount - self.item.fair_market_value, 0))

    @property
    def fair_market_value(self):
        return self.item.fair_market_value

    @classmethod
    def create_donation(cls, patron, amount, booth):
        p = Purchase.objects.create(patron=patron, amount=D(amount))
        i = PricedItem.objects.create(name='Donation', purchase=p, booth=booth)
        i.commit_to_purchase(p)
        return p

    @classmethod
    def create_priced_item(cls, patron, amount, booth):
        p = Purchase.objects.create(patron=patron, amount=D(amount))
        i = PricedItem.objects.create(name='Priced Item(s)', fair_market_value=D(amount), purchase=p, booth=booth)
        i.commit_to_purchase(p)
        return p

    @classmethod
    def purchase_item(cls, patron, amount, item):
        p = Purchase.objects.create(patron=patron, amount=D(amount))
        item.commit_to_purchase(p)
        return p


class Booth(models.Model):
    name = models.CharField(max_length=100)
    slug = models.SlugField(max_length=100, blank=True, editable=False)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super(Booth, self).save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('booth_detail', kwargs={'pk': self.pk})
