from django.test import TestCase

from .modelfactory import AuctionItemFactory, BidderFactory

class AuctionBidEntry(TestCase):

    def test_winning_bid_time_set(self):
        b = BidderFactory()
        ai = AuctionItemFactory(winning_bidder = b)
        ai.save()
        assert ai.winning_bid_time is not None

    def test_winning_bid_time_not_set(self):
        ai = AuctionItemFactory()
        ai.save()
        assert ai.winning_bid_time is None
