from django.db import models
from django.utils.timezone import datetime
from django.shortcuts import reverse


class AuctionItem(models.Model):

    name = models.CharField(max_length=50, blank=False)
    long_desc = models.TextField(blank=True)
    winning_bidder = models.ForeignKey('Bidder', blank=True)
    winning_bid_time = models.DateTimeField(blank=True, null=True)
    auction_time = models.DateTimeField(blank=True, null=True)

    def get_absolute_url(self):
        return reverse('auctionitem_detail', kwargs={'pk': self.pk})

    def save(self, *args, **kwargs):
        if self.winning_bidder:
            self.winning_bid_time = datetime.now()
        super().save(*args, **kwargs)


class Bidder(models.Model):

    bidder_num = models.CharField(max_length=8, blank=False)
    name = models.CharField(max_length=100, blank=False)

    def get_absolute_url(self):
        return reverse('bidder_detail', kwargs={'pk': self.pk})
