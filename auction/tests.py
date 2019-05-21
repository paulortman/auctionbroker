from decimal import Decimal

from django.db.models import Sum
from django.test import TestCase, override_settings
from django.utils import timezone

from auction.forms import AuctionItemEditForm
from auction.templatetags.money import money
from auction.utils import calc_cc_fee_amount, D
from .models import Purchase, Payment, round_scheduled_sale_time, AuctionItem
from .modelfactory import AuctionItemFactory, PatronFactory, BoothFactory


class AuctionBidEntry(TestCase):

    def test_winning_bid_time_set(self):
        p = PatronFactory()
        i = AuctionItemFactory()
        pur = Purchase.create_auction_item_purchase(patron=p, amount='10', auction_item=i, quantity='1')
        assert pur.transaction_time is not None
        assert i.sale_time is not None

    def test_is_purchased(self):
        p = PatronFactory()
        i = AuctionItemFactory()
        pur = Purchase.create_auction_item_purchase(patron=p, amount='10', auction_item=i, quantity='1')
        assert i.is_purchased

    def test_is_not_purchased(self):
        i = AuctionItemFactory()
        assert not i.is_purchased

    def test_winning_bid_time_not_set(self):
        i = AuctionItemFactory()
        i.save()
        assert i.sale_time is None

    # def test_unpurchasing_1(self):
    #     i = AuctionItemFactory()
    #     p = PatronFactory()
    #     assert i.is_purchased is False
    #     Purchase.create_auction_item_purchase(patron=p, auction_item=i, amount='10', quantity='1')
    #     assert i.is_purchased is True
    #     assert i.purchase is not None
    #     i.void_purchase()
    #     i.refresh_from_db()
    #     assert i.is_purchased is False
    #     assert i.purchase is None
    #
    # def test_unpurchasing_2(self):
    #     i = AuctionItemFactory.create()
    #     p = PatronFactory.create()
    #     Purchase.create_auction_item_purchase(patron=p, auction_item=i, amount='10', quantity='1')
    #     assert i.purchase is not None
    #     assert i.is_purchased is True
    #     i.void_purchase()
    #     assert i.purchase is None
    #     assert i.is_purchased is False
    #     assert Purchase.objects.all().count() == 0



# class TestAuctionItemForms():
#
#     def test_update_auction_item(self):
#         i = AuctionItemFactory()
#         p = PatronFactory()
#         Purchase.create_auction_item_purchase(patron=p, item=i, amount='10')
#
#         form = AuctionItemEditForm(instance=i)
#         data = form.initial






class PurchaseTestCase(TestCase):

    def test_no_purchases(self):
        p = PatronFactory()
        assert p.outstanding_balance == Decimal('0')

    def test_one_purchase(self):
        p = PatronFactory()
        Purchase.objects.create(patron=p, amount='10.00')
        assert p.outstanding_balance == Decimal('10.00')

    def test_multiple_purchases(self):
        p = PatronFactory()
        Purchase.objects.create(patron=p, amount='10.00')
        Purchase.objects.create(patron=p, amount='10.00')
        Purchase.objects.create(patron=p, amount='10.00')
        Purchase.objects.create(patron=p, amount='10.00')
        assert p.outstanding_balance == Decimal('40.00')

    def test_new_donation(self):
        p = PatronFactory()
        booth = BoothFactory()
        pur = Purchase.create_donation(patron=p, amount='10.00', booth=booth)
        assert pur.donation_amount == Decimal('10.00')
        assert p.outstanding_balance == Decimal('10.00')

    def test_new_priced_purchase(self):
        p = PatronFactory()
        booth = BoothFactory()
        pur = Purchase.create_priced_purchase(patron=p, amount='10.00', booth=booth)
        assert pur.donation_amount == Decimal('0.00')
        assert p.outstanding_balance == Decimal('10.00')

    def test_new_auction_purchase(self):
        p = PatronFactory()
        ai = AuctionItemFactory(fair_market_value=Decimal('10.00'))
        pur = Purchase.create_auction_item_purchase(patron=p, amount='10.00', auction_item=ai, quantity='1')
        assert pur.donation_amount == Decimal('0.00')
        assert p.outstanding_balance == Decimal('10.00')


class PaymentsTestCase(TestCase):

    def setUp(self):
        self.p = PatronFactory()
        self.booth = BoothFactory()

    def test_full_payment(self):
        Purchase.create_priced_purchase(patron=self.p, amount='10.00', booth=self.booth)
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.outstanding_balance == Decimal('10.00')
        Payment.objects.create(patron=self.p, amount='10.00')
        assert self.p.outstanding_balance == Decimal('0.00')
        assert self.p.account_is_settled
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.donations_total == Decimal('0.00')

    def test_partial_payment(self):
        Purchase.create_priced_purchase(patron=self.p, amount='10.00', booth=self.booth)
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.outstanding_balance == Decimal('10.00')
        Payment.objects.create(patron=self.p, amount='5.00')
        assert self.p.outstanding_balance == Decimal('5.00')
        assert not self.p.account_is_settled
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.donations_total == Decimal('0.00')

    def test_over_payment(self):
        Purchase.create_priced_purchase(patron=self.p, amount='10.00', booth=self.booth)
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.outstanding_balance == Decimal('10.00')
        Payment.objects.create(patron=self.p, amount='15.00')
        assert self.p.outstanding_balance == Decimal('-5.00')
        assert not self.p.account_is_settled
        assert self.p.purchases_total == Decimal('10.00')
        assert self.p.donations_total == Decimal('0.00')

    # def test_no_negative_donation(self):
    #     i = AuctionItemFactory(fair_market_value='10')
    #     p = PatronFactory()
    #     pur = Purchase.create_auction_item_purchase(patron=p, amount=Decimal('5.00'), auction_item=i, quantity='1')
    #     pay = Payment.objects.create(patron=p, amount=Decimal('5'))
    #     assert p.donations_total == 0
    #     assert p.outstanding_balance == 0



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


class UtilityTestCase(TestCase):

    def test_fee_rounding_down(self):
        assert D('0.09') == calc_cc_fee_amount(D('3.12'))

    def test_fee_rounding_up(self):
        assert D('0.10') == calc_cc_fee_amount(D('3.17'))


class BlessingBidTestCase(TestCase):

    def setUp(self) -> None:
        # we have a single auction item that more than one bidder "buys"
        self.ai = AuctionItemFactory()

        self.buyer1 = PatronFactory()
        self.buyer2 = PatronFactory()

    def test_more_than_one_bidder(self):
        purchase1 = Purchase.create_auction_item_purchase(patron=self.buyer1, amount='10.00',
                                                          auction_item=self.ai, quantity=1)
        purchase2 = Purchase.create_auction_item_purchase(patron=self.buyer2, amount='10.00',
                                                          auction_item=self.ai, quantity=1)

        assert self.ai.purchase_set.count() == 2
        assert self.ai.purchase_set.aggregate(Sum('amount'))['amount__sum'] == 20

    def test_multiple_diverse_amounts(self):
        purchase1 = Purchase.create_auction_item_purchase(patron=self.buyer1, amount='500.00',
                                                          auction_item=self.ai, quantity=1)
        purchase2 = Purchase.create_auction_item_purchase(patron=self.buyer2, amount='111.00',
                                                          auction_item=self.ai, quantity=1)

        assert self.ai.purchase_set.count() == 2
        assert self.ai.purchase_set.aggregate(Sum('amount'))['amount__sum'] == 611
