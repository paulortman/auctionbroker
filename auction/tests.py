from django.test import TestCase
from moneyed import Money

from .models import Purchase, Payment
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
        assert b.outstanding_purchases_total == Money('0', 'USD')

    def test_one_purchase(self):
        b = BuyerFactory()
        Purchase.objects.create(buyer=b, amount='10.00')
        assert b.outstanding_purchases_total == Money('10.00', 'USD')

    def test_multiple_purchases(self):
        b = BuyerFactory()
        Purchase.objects.create(buyer=b, amount='10.00')
        Purchase.objects.create(buyer=b, amount='10.00')
        Purchase.objects.create(buyer=b, amount='10.00')
        Purchase.objects.create(buyer=b, amount='10.00')
        assert b.outstanding_purchases_total == Money('40.00', 'USD')

    def test_some_paid(self):
        b = BuyerFactory()
        Purchase.objects.create(buyer=b, amount='10.00')
        Purchase.objects.create(buyer=b, amount='10.00')
        Purchase.objects.create(buyer=b, amount='10.00', state=Purchase.PAID)
        Purchase.objects.create(buyer=b, amount='10.00', state=Purchase.PAID)
        assert b.outstanding_purchases_total == Money('20.00', 'USD')

    def test_new_donation(self):
        b = BuyerFactory()
        booth = BoothFactory()
        p = Purchase.create_donation(buyer=b, amount='10.00', booth=booth)
        assert p.donation_amount == Money('10.00', 'USD')

    def test_new_priced_item(self):
        b = BuyerFactory()
        booth = BoothFactory()
        p = Purchase.create_priced_item(buyer=b, amount='10.00', booth=booth)
        assert p.donation_amount == Money('0.00', 'USD')


class PaymentsTestCase(TestCase):

    def setUp(self):
        self.b = BuyerFactory()
        self.booth = BoothFactory()

    def test_full_payment(self):
        Purchase.create_priced_item(buyer=self.b, amount='10.00', booth=self.booth)
        assert self.b.purchases_total == Money('10.00', 'USD')
        assert self.b.outstanding_balance == Money('10.00', 'USD')
        Payment.objects.create(buyer=self.b, amount='10.00')
        assert self.b.outstanding_balance == Money('0.00', 'USD')
        assert self.b.account_is_settled
        assert self.b.purchases_total == Money('10.00', 'USD')
        assert self.b.donations_total == Money('0.00', 'USD')

    def test_partial_payment(self):
        Purchase.create_priced_item(buyer=self.b, amount='10.00', booth=self.booth)
        assert self.b.purchases_total == Money('10.00', 'USD')
        assert self.b.outstanding_balance == Money('10.00', 'USD')
        Payment.objects.create(buyer=self.b, amount='5.00')
        assert self.b.outstanding_balance == Money('5.00', 'USD')
        assert not self.b.account_is_settled
        assert self.b.purchases_total == Money('10.00', 'USD')
        assert self.b.donations_total == Money('0.00', 'USD')

    def test_over_payment(self):
        Purchase.create_priced_item(buyer=self.b, amount='10.00', booth=self.booth)
        assert self.b.purchases_total == Money('10.00', 'USD')
        assert self.b.outstanding_balance == Money('10.00', 'USD')
        Payment.objects.create(buyer=self.b, amount='15.00')
        assert self.b.outstanding_balance == Money('-5.00', 'USD')
        assert not self.b.account_is_settled
        assert self.b.purchases_total == Money('10.00', 'USD')
        assert self.b.donations_total == Money('0.00', 'USD')

