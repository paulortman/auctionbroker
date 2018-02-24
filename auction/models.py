import json

from django.core.exceptions import ValidationError
from django.db import models
from django.db.models import Max
from django.conf import settings
from django.utils import timezone
from django.shortcuts import reverse
from channels.channel import Group
from django.dispatch import receiver
from django.db.models.signals import post_save
from django.utils.text import slugify
from djmoney.models.fields import MoneyField
from djmoney.money import Money


class Item(models.Model):
    class Meta:
        abstract = True

    name = models.CharField(max_length=50, blank=False)
    long_desc = models.TextField(blank=True)
    purchase = models.OneToOneField('Purchase', blank=True, null=True)
    booth = models.ForeignKey('Booth', blank=True, null=True)
    sale_time = models.DateTimeField(blank=True, null=True)
    fair_market_value = MoneyField(max_digits=15, decimal_places=2, default_currency='USD')
    is_purchased = models.BooleanField(default=False)

    def __str__(self):
        return "({}) {}{}".format(self.id, self.name, "*" if self.purchase else "")

    def commit_to_purchase(self, purchase):
        self.purchase = purchase
        self.sale_time = timezone.now()
        self.is_purchased = True
        self.save()


class PricedItem(Item):
    pass


def item_number_generator():
    try:
        value = AuctionItem.objects.all().aggregate(Max('item_number'))['item_number__max']
    except AuctionItem.DoesNotExist:
        value = 0
    value = 0 if value is None else value
    return max([value, settings.BASE_AUCTION_NUMBER]) + 1


class AuctionItem(Item):
    class Meta:
        pass

    item_number = models.PositiveIntegerField(unique=True, db_index=True, default=item_number_generator)
    scheduled_sale_time = models.DateTimeField(blank=True, null=True)

    def get_absolute_url(self):
        return reverse('item_detail', kwargs={'item_number': self.item_number})

@receiver(post_save, sender=Item)
def send_sale_event(sender, instance, **kwargs):
    if instance.purchase_id:
        Group('sales_events').send({
            'text': json.dumps({
                'id': instance.id,
                'name': instance.name,
                'purchase_id': instance.purchase_id
            })
        })
        print("Sent Event")


class Buyer(models.Model):

    buyer_num = models.CharField(max_length=8)
    name = models.CharField(max_length=100)

    def get_absolute_url(self):
        return reverse('buyer_detail', kwargs={'pk': self.pk})

    @property
    def outstanding_purchases_total(self):
        s = self.purchases.filter(state=Purchase.UNPAID).aggregate(models.Sum('amount'))['amount__sum']
        return Money(s, 'USD') if s else Money(0, 'USD')

    @property
    def purchases_total(self):
        purchases = self.purchases.all().aggregate(models.Sum('amount'))['amount__sum']
        return Money(purchases, 'USD') if purchases else Money('0', 'USD')

    @property
    def payments_total(self):
        payments = self.payments.all().aggregate(models.Sum('amount'))['amount__sum']
        return Money(payments, 'USD') if payments else Money('0', 'USD')

    @property
    def donations_total(self):
        fmv_priced = self.purchases.all().aggregate(models.Sum('priceditem__fair_market_value'))['priceditem__fair_market_value__sum']
        fmv_auction = self.purchases.all().aggregate(models.Sum('auctionitem__fair_market_value'))['auctionitem__fair_market_value__sum']
        fmv_priced = Money(fmv_priced, 'USD') if fmv_priced else Money('0', 'USD')
        fmv_auction = Money(fmv_auction, 'USD') if fmv_auction else Money('0', 'USD')
        return self.purchases_total - (fmv_priced + fmv_auction)

    @property
    def outstanding_balance(self):
        return self.purchases_total - self.payments_total

    @property
    def account_is_settled(self):
        return self.outstanding_balance == Money('0.00', 'USD')


def buyer_number_validator(value):
    try:
        buyer_num = int(value)
    except ValueError:
        raise ValidationError("'%(value)s' is not a valid Buyer Number", params={'value': value})

    try:
        buyer = Buyer.objects.get(buyer_num=buyer_num)
    except Buyer.DoesNotExist:
        raise ValidationError("No buyer exists for buyer number '%(value)s'", params={'value': value})




class Payment(models.Model):
    CASH = 'CASH'
    CHECK = 'CHECK'
    CARD = 'CARD'
    METHODS = (
        (CASH, 'Cash'),
        (CHECK, 'Check'),
        (CARD, 'Card')
    )
    buyer = models.ForeignKey('Buyer', related_name='payments')
    amount = MoneyField(max_digits=15, decimal_places=2, default_currency='USD')
    method = models.CharField(choices=METHODS, default='CHECK', max_length=6)
    transaction_time = models.DateTimeField(auto_now_add=True, blank=True, null=True)


class Purchase(models.Model):
    UNPAID = 'UNPAID'
    PAID = 'PAID'
    VOID = 'VOID'
    STATES = (
        (UNPAID, 'Unpaid'),
        (PAID, 'Paid'),
        (VOID, 'Void')
    )

    buyer = models.ForeignKey('Buyer', related_name='purchases')
    amount = MoneyField(max_digits=15, decimal_places=2, default_currency='USD')
    state = models.CharField(choices=STATES, default='UNPAID', max_length=7)
    transaction_time = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    paid_time = models.DateTimeField(blank=True, null=True)

    def get_absolute_url(self):
        return reverse('purchase_detail', kwargs={'pk': self.pk})

    def save(self, *args, **kwargs):
        if self.state == self.PAID:
            self.paid_time = timezone.now()
        else:
            self.paid_time = None

        super().save(*args, **kwargs)

    @property
    def item(self):
        if hasattr(self, 'priceditem'):
            return self.priceditem
        if hasattr(self, 'auctionitem'):
            return self.auctionitem

        raise AttributeError('Purchase object has no valid \'item\' attribute')

    @property
    def donation_amount(self):

        return self.amount - self.item.fair_market_value

    @property
    def fair_market_value(self):
        return self.item.fair_market_value

    @classmethod
    def create_donation(cls, buyer, amount, booth):
        p = Purchase.objects.create(buyer=buyer, amount=amount)
        i = PricedItem.objects.create(name='Donation', purchase=p, booth=booth)
        i.commit_to_purchase(p)
        return p

    @classmethod
    def create_priced_item(cls, buyer, amount, booth):
        p = Purchase.objects.create(buyer=buyer, amount=amount)
        i = PricedItem.objects.create(name='{} Item'.format(booth.name),
                                      fair_market_value=amount, purchase=p, booth=booth)
        i.commit_to_purchase(p)
        return p

    @classmethod
    def purchase_item(cls, buyer, amount, item):
        p = Purchase.objects.create(buyer=buyer, amount=amount)
        item.commit_to_purchase(p)
        return p


class Booth(models.Model):

    name = models.CharField(max_length=100)
    slug = models.SlugField(max_length=100, blank=True, editable=False)
    uses_item_inventory = models.BooleanField(default=False)
    can_adjust_fmv = models.BooleanField(default=False)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super(Booth, self).save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('booth_detail', kwargs={'pk': self.pk})
