from decimal import Decimal
from django.test import TestCase, override_settings
from django.utils import timezone

from auction.forms import AuctionItemEditForm
from auction.templatetags.money import money
from .models import Purchase, Payment, round_scheduled_sale_time, AuctionItem
from .modelfactory import AuctionItemFactory, BuyerFactory, BoothFactory


class AuctionBidEntry(TestCase):

    def test_winning_bid_time_set(self):
        b = BuyerFactory()
        i = AuctionItemFactory()
        p = Purchase.purchase_item(buyer=b, amount='10', item=i)
        assert i.purchase.transaction_time is not None

    def test_winning_bid_time_not_set(self):
        i = AuctionItemFactory()
        i.save()
        assert i.purchase is None

    def test_unpurchasing_1(self):
        i = AuctionItemFactory()
        b = BuyerFactory()
        assert i.purchase is None
        p = Purchase.purchase_item(buyer=b, item=i, amount='10')
        i = AuctionItem.objects.get(pk=i.pk)
        assert i.is_purchased is True
        assert i.purchase is not None
        i.void_purchase()
        i.refresh_from_db()
        assert i.is_purchased is False
        assert i.purchase is None

    def test_unpurchasing_2(self):
        i = AuctionItemFactory.create()
        b = BuyerFactory.create()
        Purchase.purchase_item(buyer=b, item=i, amount='10')
        assert i.purchase is not None
        assert i.is_purchased is True
        i.void_purchase()
        assert i.purchase is None
        assert i.is_purchased is False
        assert Purchase.objects.all().count() == 0



class TestAuctionItemForms():

    def test_update_auction_item(self):
        i = AuctionItemFactory()
        b = BuyerFactory()
        Purchase.purchase_item(buyer=b, item=i, amount='10')

        form = AuctionItemEditForm(instance=i)
        data = form.initial






class PurchaseTestCase(TestCase):

    def test_no_purchases(self):
        b = BuyerFactory()
        assert b.outstanding_purchases_total == Decimal('0')

    def test_one_purchase(self):
        b = BuyerFactory()
        Purchase.objects.create(buyer=b, amount='10.00')
        assert b.outstanding_purchases_total == Decimal('10.00')

    def test_multiple_purchases(self):
        b = BuyerFactory()
        Purchase.objects.create(buyer=b, amount='10.00')
        Purchase.objects.create(buyer=b, amount='10.00')
        Purchase.objects.create(buyer=b, amount='10.00')
        Purchase.objects.create(buyer=b, amount='10.00')
        assert b.outstanding_purchases_total == Decimal('40.00')

    def test_new_donation(self):
        b = BuyerFactory()
        booth = BoothFactory()
        p = Purchase.create_donation(buyer=b, amount='10.00', booth=booth)
        assert p.donation_amount == Decimal('10.00')

    def test_new_priced_item(self):
        b = BuyerFactory()
        booth = BoothFactory()
        p = Purchase.create_priced_item(buyer=b, amount='10.00', booth=booth)
        assert p.donation_amount == Decimal('0.00')


class PaymentsTestCase(TestCase):

    def setUp(self):
        self.b = BuyerFactory()
        self.booth = BoothFactory()

    def test_full_payment(self):
        Purchase.create_priced_item(buyer=self.b, amount='10.00', booth=self.booth)
        assert self.b.purchases_total == Decimal('10.00')
        assert self.b.outstanding_balance == Decimal('10.00')
        Payment.objects.create(buyer=self.b, amount='10.00')
        assert self.b.outstanding_balance == Decimal('0.00')
        assert self.b.account_is_settled
        assert self.b.purchases_total == Decimal('10.00')
        assert self.b.donations_total == Decimal('0.00')

    def test_partial_payment(self):
        Purchase.create_priced_item(buyer=self.b, amount='10.00', booth=self.booth)
        assert self.b.purchases_total == Decimal('10.00')
        assert self.b.outstanding_balance == Decimal('10.00')
        Payment.objects.create(buyer=self.b, amount='5.00')
        assert self.b.outstanding_balance == Decimal('5.00')
        assert not self.b.account_is_settled
        assert self.b.purchases_total == Decimal('10.00')
        assert self.b.donations_total == Decimal('0.00')

    def test_over_payment(self):
        Purchase.create_priced_item(buyer=self.b, amount='10.00', booth=self.booth)
        assert self.b.purchases_total == Decimal('10.00')
        assert self.b.outstanding_balance == Decimal('10.00')
        Payment.objects.create(buyer=self.b, amount='15.00')
        assert self.b.outstanding_balance == Decimal('-5.00')
        assert not self.b.account_is_settled
        assert self.b.purchases_total == Decimal('10.00')
        assert self.b.donations_total == Decimal('0.00')

    def test_no_negative_donation(self):
        i = AuctionItemFactory(fair_market_value='10')
        b = BuyerFactory()
        p = Purchase.purchase_item(buyer=b, item=i, amount='5')
        pay = Payment.objects.create(buyer=b, amount='5')
        assert b.donations_total == 0
        assert b.outstanding_balance == 0



class MoneyTestCase(TestCase):

    def test_zero_format(self):
        assert "$0.00" == money(Decimal('0'))

    def test_100_format(self):
        assert "$100.00" == money(Decimal('100'))

    def test_negative_format(self):
        assert "$-100.00" == money(Decimal('-100'))


class ScheduledTimeTestCase(TestCase):

    @override_settings(AUCTIONITEM_SCHEDULED_TIME_INCREMENT=5)
    def test_round_up(self):
        dt = timezone.datetime(year=2018, month=2, day=28, hour=12, minute=7, second=30)
        rounded = round_scheduled_sale_time(dt)
        assert rounded == timezone.datetime(year=2018, month=2, day=28, hour=12, minute=10, second=0)

    @override_settings(AUCTIONITEM_SCHEDULED_TIME_INCREMENT=5)
    def test_round_down(self):
        dt = timezone.datetime(year=2018, month=2, day=28, hour=12, minute=7, second=29)
        rounded = round_scheduled_sale_time(dt)
        assert rounded == timezone.datetime(year=2018, month=2, day=28, hour=12, minute=5, second=0)
