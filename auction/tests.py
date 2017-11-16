from decimal import Decimal
from django.test import TestCase

from .models import Purchase
from .modelfactory import ItemFactory, BuyerFactory, BoothFactory


class AuctionBidEntry(TestCase):

    def test_winning_bid_time_set(self):
        b = BuyerFactory()
        p = Purchase.objects.create(buyer=b, amount='10')
        i = ItemFactory(purchase=p)
        i.save()
        assert i.purchase.transaction_time is not None

    def test_winning_bid_time_not_set(self):
        i = ItemFactory()
        i.save()
        assert i.purchase is None


class PurchaseTestCase(TestCase):

    def test_no_purchases(self):
        b = BuyerFactory()
        assert b.outstanding_purchases_total == 0

    def test_one_purchase(self):
        b = BuyerFactory()
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'))
        assert b.outstanding_purchases_total == Decimal('10.00')

    def test_multiple_purchases(self):
        b = BuyerFactory()
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'))
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'))
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'))
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'))
        assert b.outstanding_purchases_total == Decimal('40.00')

    def test_some_paid(self):
        b = BuyerFactory()
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'))
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'))
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'), state=Purchase.PAID)
        Purchase.objects.create(buyer=b, amount=Decimal('10.00'), state=Purchase.PAID)
        assert b.outstanding_purchases_total == Decimal('20.00')

    def test_new_donation(self):
        b = BuyerFactory()
        booth = BoothFactory()
        p = Purchase.build_donation(buyer=b, amount=Decimal('10.00'), booth=booth)
        assert p.donation_amount == Decimal('10.00')

    def test_new_priced_item(self):
        b = BuyerFactory()
        booth = BoothFactory()
        p = Purchase.build_priced_item(buyer=b, amount=Decimal('10.00'), booth=booth)
        assert p.donation_amount == Decimal('0.00')
