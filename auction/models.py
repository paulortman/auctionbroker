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
    winning_bidder = models.ForeignKey('Bidder', blank=True, null=True)
    winning_bid_time = models.DateTimeField(blank=True, null=True)
    auction_time = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return "({}) {}{}".format(self.id, self.name, "*" if self.winning_bidder_id else "")

    def get_absolute_url(self):
        return reverse('auctionitem_detail', kwargs={'pk': self.pk})

    def save(self, *args, **kwargs):
        if self.winning_bidder_id:
            self.winning_bid_time = timezone.now()
        super().save(*args, **kwargs)


@receiver(post_save, sender=AuctionItem)
def send_sale_event(sender, instance, **kwargs):
    if instance.winning_bidder_id:
        Group('sales_events').send({
            'text': json.dumps({
                'id': instance.id,
                'name': instance.name,
                'winning_bidder_id': instance.winning_bidder_id
            })
        })
        print("Sent Event")



class Bidder(models.Model):

    bidder_num = models.CharField(max_length=8)
    name = models.CharField(max_length=100)

    def get_absolute_url(self):
        return reverse('bidder_detail', kwargs={'pk': self.pk})


