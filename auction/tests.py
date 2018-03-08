from decimal import Decimal
from django.test import TestCase, override_settings
from django.utils import timezone

from auction.forms import AuctionItemEditForm
from auction.templatetags.money import money
from .models import Purchase, Payment, round_scheduled_sale_time, AuctionItem
from .modelfactory import AuctionItemFactory, PatronFactory, BoothFactory


class AuctionBidEntry(TestCase):

    def test_winning_bid_time_set(self):
        p = PatronFactory()
        i = AuctionItemFactory()
        Purchase.purchase_item(patron=p, amount='10', item=i)
        assert i.purchase.transaction_time is not None

    def test_winning_bid_time_not_set(self):
        i = AuctionItemFactory()
        i.save()
        assert i.purchase is None

    def test_unpurchasing_1(self):
        i = AuctionItemFactory()
        p = PatronFactory()
        assert i.purchase is None
        Purchase.purchase_item(patron=p, item=i, amount='10')
        i = AuctionItem.objects.get(pk=i.pk)
        assert i.is_purchased is True
        assert i.purchase is not None
        i.void_purchase()
        i.refresh_from_db()
        assert i.is_purchased is False
        assert i.purchase is None

    def test_unpurchasing_2(self):
        i = AuctionItemFactory.create()
        p = PatronFactory.create()
        Purchase.purchase_item(patron=p, item=i, amount='10')
        assert i.purchase is not None
        assert i.is_purchased is True
        i.void_purchase()
        assert i.purchase is None
        assert i.is_purchased is False
        assert Purchase.objects.all().count() == 0



# class TestAuctionItemForms():
#
#     def test_update_auction_item(self):
#         i = AuctionItemFactory()
#         p = PatronFactory()
#         Purchase.purchase_item(patron=p, item=i, amount='10')
#
#         form = AuctionItemEditForm(instance=i)
#         data = form.initial






class PurchaseTestCase(TestCase):

    def test_no_purchases(self):
        p = PatronFactory()
        assert p.outstanding_purchases_total == Decimal('0')

    def test_one_purchase(self):
        p = PatronFactory()
        Purchase.objects.create(patron=p, amount='10.00')
        assert p.outstanding_purchases_total == Decimal('10.00')

    def test_multiple_purchases(self):
        p = PatronFactory()
        Purchase.objects.create(patron=p, amount='10.00')
        Purchase.objects.create(patron=p, amount='10.00')
        Purchase.objects.create(patron=p, amount='10.00')
        Purchase.objects.create(patron=p, amount='10.00')
        assert p.outstanding_purchases_total == Decimal('40.00')

    def test_new_donation(self):
        p = PatronFactory()
        booth = BoothFactory()
        pur = Purchase.create_donation(patron=p, amount='10.00', booth=booth)
        assert pur.donation_amount == Decimal('10.00')

    def test_new_priced_item(self):
        p = PatronFactory()
        booth = BoothFactory()
        pur = Purchase.create_priced_item(patron=p, amount='10.00', booth=booth)
        assert pur.donation_amount == Decimal('0.00')


class PaymentsTestCase(TestCase):

    def setUp(self):
        self.p = PatronFactory()
        self.booth = BoothFactory()

    def test_full_payment(self):
        Purchase.create_priced_item(patron=self.p, amount='10.00', booth=self.booth)
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.outstanding_balance == Decimal('10.00')
        Payment.objects.create(patron=self.p, amount='10.00')
        assert self.p.outstanding_balance == Decimal('0.00')
        assert self.p.account_is_settled
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.donations_total == Decimal('0.00')

    def test_partial_payment(self):
        Purchase.create_priced_item(patron=self.p, amount='10.00', booth=self.booth)
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.outstanding_balance == Decimal('10.00')
        Payment.objects.create(patron=self.p, amount='5.00')
        assert self.p.outstanding_balance == Decimal('5.00')
        assert not self.p.account_is_settled
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.donations_total == Decimal('0.00')

    def test_over_payment(self):
        Purchase.create_priced_item(patron=self.p, amount='10.00', booth=self.booth)
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.outstanding_balance == Decimal('10.00')
        Payment.objects.create(patron=self.p, amount='15.00')
        assert self.p.outstanding_balance == Decimal('-5.00')
        assert not self.p.account_is_settled
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.donations_total == Decimal('0.00')

    def test_no_negative_donation(self):
        i = AuctionItemFactory(fair_market_value='10')
        p = PatronFactory()
        pur = Purchase.purchase_item(patron=p, item=i, amount='5')
        pay = Payment.objects.create(patron=p, amount='5')
        assert p.donations_total == 0
        assert p.outstanding_balance == 0



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
