import random

from decimal import Decimal
from django.core.management.base import BaseCommand, CommandError

from auction.models import Buyer, Booth, Purchase, AuctionItem


class Command(BaseCommand):
    help = 'Purchase a subset of all auction items and a number of purchased items'

    def handle(self, *args, **kwargs):

        # Half the registered buyers buy priced item
        buyer_cnt = Buyer.objects.all().count()
        buyer_sample = random.sample(list(Buyer.objects.all()), int(buyer_cnt * 0.5))  # 50% sample

        booths = list(Booth.objects.exclude(name="Auction"))
        prices = ['1', '1.5', '2', '2', '2.5', '2.5', '2.5', '4', '5', '10']

        for buyer in buyer_sample:
            priced_purchases = random.randint(1, 5)
            for purchase in range(priced_purchases):
                booth = random.choice(booths)
                price = Decimal(random.choice(prices))
                Purchase.create_priced_item(buyer=buyer, amount=price, booth=booth)
                print('p', end='')

        # 90 percent of the auction items are purchased -- in scheduled order
        items_cnt = AuctionItem.objects.all().count()
        items = AuctionItem.objects.all()[0:int(items_cnt * 0.9)]

        buyer_sample = random.sample(list(Buyer.objects.all()), int(buyer_cnt * 0.3))  # 30% sample
        for item in items:
            # amount is between 100 - 115 % of the fmv
            amount = item.fair_market_value * Decimal(random.randint(100, 115) / 100.0)
            buyer = random.choice(buyer_sample)
            Purchase.purchase_item(buyer=buyer, amount=amount, item=item)
            print('i', end='')

        print("\nPurchases Done.")
