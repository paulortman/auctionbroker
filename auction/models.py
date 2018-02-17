import json
from django.db import models
from django.utils import timezone
from django.shortcuts import reverse
from channels.channel import Group
from django.dispatch import receiver
from django.db.models.signals import post_save
from django.utils.text import slugify
from djmoney.models.fields import MoneyField
from djmoney.money import Money


class Item(models.Model):

    name = models.CharField(max_length=50, blank=False)
    long_desc = models.TextField(blank=True)
    scheduled_sale_time = models.DateTimeField(blank=True, null=True)
    purchase = models.OneToOneField('Purchase', blank=True, null=True)
    amount = MoneyField(max_digits=15, decimal_places=2, default_currency='USD')
    booth = models.ForeignKey('Booth', blank=True, null=True)
    fair_market_value = MoneyField(max_digits=15, decimal_places=2, default_currency='USD')

    def __str__(self):
        return "({}) {}{}".format(self.id, self.name, "*" if self.purchase else "")

    def get_absolute_url(self):
        return reverse('item_detail', kwargs={'pk': self.pk})


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
    def donation_amount(self):
        return self.amount - self.item.fair_market_value

    @property
    def fair_market_value(self):
        return self.item.fair_market_value

    @classmethod
    def build_donation(cls, buyer, amount, booth):
        p = Purchase(buyer=buyer, amount=amount)
        Item(name='Donation', purchase=p, booth=booth)
        return p

    @classmethod
    def create_donation(cls, buyer, amount, booth):
        return Purchase.build_donation(buyer, amount, booth).save()

    @classmethod
    def build_priced_item(cls, buyer, amount, booth):
        p = Purchase(buyer=buyer, amount=amount)
        Item(name='Donation', fair_market_value=amount, purchase=p, booth=booth)
        return p

    @classmethod
    def create_priced_item(cls, buyer, amount, booth):
        p = Purchase.objects.create(buyer=buyer, amount=amount)
        Item.objects.create(name='Donation', fair_market_value=amount, purchase=p, booth=booth)
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
