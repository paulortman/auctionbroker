import json
from decimal import Decimal
from django.db import models
from django.utils import timezone
from django.shortcuts import reverse
from channels.channel import Group
from django.dispatch import receiver
from django.db.models.signals import post_save


class Item(models.Model):

    name = models.CharField(max_length=50, blank=False)
    long_desc = models.TextField(blank=True)
    scheduled_sale_time = models.DateTimeField(blank=True, null=True)
    purchase = models.OneToOneField('Purchase', blank=True, null=True)
    fair_market_value = models.DecimalField(max_digits=15, decimal_places=2, default=Decimal('0.0'))
    booth = models.ForeignKey('Booth', blank=True, null=True)

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
        return s if s else 0


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
    amount = models.DecimalField(max_digits=15, decimal_places=2, default=Decimal('0.0'))
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
        p = Purchase(buyer=buyer, amount=Decimal(amount))
        Item(name='Donation', purchase=p, booth=booth)
        return p

    @classmethod
    def create_donation(cls, buyer, amount, booth):
        return Purchase.build_donation(buyer, amount, booth).save()

    @classmethod
    def build_priced_item(cls, buyer, amount, booth):
        p = Purchase(buyer=buyer, amount=Decimal(amount))
        Item(name='Donation', fair_market_value=Decimal(amount), purchase=p, booth=booth)
        return p

    @classmethod
    def create_priced_item(cls, buyer, amount, booth):
        return Purchase.build_priced_item(buyer, amount, booth).save()

class Booth(models.Model):

    name = models.CharField(max_length=100)
