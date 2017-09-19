from decimal import Decimal
from django.test import TestCase

from .models import Charge
from .modelfactory import AuctionItemFactory, BidderFactory


class AuctionBidEntry(TestCase):

    def test_winning_bid_time_set(self):
        b = BidderFactory()
        c = Charge.objects.create(bidder=b, amount='10')
        ai = AuctionItemFactory(charge=c)
        ai.save()
        assert ai.winning_bid_time is not None

    def test_winning_bid_time_not_set(self):
        ai = AuctionItemFactory()
        ai.save()
        assert ai.winning_bid_time is None


class ChargesTestCase(TestCase):

    def test_no_charges(self):
        b = BidderFactory()
        assert b.outstanding_charges_total == 0

    def test_one_charge(self):
        b = BidderFactory()
        Charge.objects.create(bidder=b, amount='10.00')
        assert b.outstanding_charges_total == Decimal('10.00')

    def test_multiple_charges(self):
        b = BidderFactory()
        Charge.objects.create(bidder=b, amount='10.00')
        Charge.objects.create(bidder=b, amount='10.00')
        Charge.objects.create(bidder=b, amount='10.00')
        Charge.objects.create(bidder=b, amount='10.00')
        assert b.outstanding_charges_total == Decimal('40.00')

    def test_some_paid(self):
        b = BidderFactory()
        Charge.objects.create(bidder=b, amount='10.00')
        Charge.objects.create(bidder=b, amount='10.00')
        Charge.objects.create(bidder=b, amount='10.00', state=Charge.PAID)
        Charge.objects.create(bidder=b, amount='10.00', state=Charge.PAID)
        assert b.outstanding_charges_total == Decimal('20.00')
