import json
from django.db import models
from django.utils import timezone
from django.shortcuts import reverse
from channels.channel import Group
from django.dispatch import receiver
from django.db.models.signals import post_save


class AuctionItem(models.Model):

    name = models.CharField(max_length=50, blank=False)
    long_desc = models.TextField(blank=True)
    winning_bid_time = models.DateTimeField(blank=True, null=True)
    auction_time = models.DateTimeField(blank=True, null=True)
    charge = models.OneToOneField('Charge', blank=True, null=True)

    def __str__(self):
        return "({}) {}{}".format(self.id, self.name, "*" if self.charge else "")

    def get_absolute_url(self):
        return reverse('auctionitem_detail', kwargs={'pk': self.pk})

    def save(self, *args, **kwargs):
        if self.charge:
            self.winning_bid_time = timezone.now()
        super().save(*args, **kwargs)


@receiver(post_save, sender=AuctionItem)
def send_sale_event(sender, instance, **kwargs):
    if instance.charge_id:
        Group('sales_events').send({
            'text': json.dumps({
                'id': instance.id,
                'name': instance.name,
                'charge_id': instance.charge_id
            })
        })
        print("Sent Event")


class Bidder(models.Model):

    bidder_num = models.CharField(max_length=8)
    name = models.CharField(max_length=100)

    def get_absolute_url(self):
        return reverse('bidder_detail', kwargs={'pk': self.pk})

    @property
    def outstanding_charges_total(self):
        s = self.charges.filter(state=Charge.UNPAID).aggregate(models.Sum('amount'))['amount__sum']
        return s if s else 0


class Charge(models.Model):
    UNPAID = 'UNPAID'
    PAID = 'PAID'
    VOID = 'VOID'
    STATES = (
        (UNPAID, 'Unpaid'),
        (PAID, 'Paid'),
        (VOID, 'Void')
    )

    bidder = models.ForeignKey('Bidder', related_name='charges')
    amount = models.DecimalField(max_digits=7, decimal_places=2)
    state = models.CharField(choices=STATES, default='UNPAID', max_length=7)

    def get_absolute_url(self):
        return reverse('charge_detail', kwargs={'pk': self.pk})

