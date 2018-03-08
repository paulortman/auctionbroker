import random

from decimal import Decimal
from django.core.management.base import BaseCommand, CommandError
from django.utils import timezone

from auction.models import Patron, Booth, Purchase, AuctionItem


class Command(BaseCommand):
    help = 'Purchase a subset of all auction items and a number of purchased items'

    def handle(self, *args, **kwargs):

        # Half the registered patrons buy priced item
        patron_cnt = Patron.objects.all().count()
        patron_sample = random.sample(list(Patron.objects.all()), int(patron_cnt * 0.5))  # 50% sample

        base_time = timezone.now()

        booths = list(Booth.objects.exclude(name="Auction"))
        prices = ['1', '1.5', '2', '2', '2.5', '2.5', '2.5', '4', '5', '10']

        for patron in patron_sample:
            priced_purchases = random.randint(1, 5)
            for purchase in range(priced_purchases):
                booth = random.choice(booths)
                price = Decimal(random.choice(prices))
                p = Purchase.create_priced_item(patron=patron, amount=price, booth=booth)
                minutes = random.randint(1, 8 * 60)  # spread purchases over 8 hours
                p.transaction_time = base_time + timezone.timedelta(minutes=minutes)
                p.save()
                print('p', end='')

        # 90 percent of the auction items are purchased -- in scheduled order
        items_cnt = AuctionItem.objects.all().count()
        items = AuctionItem.objects.all()[0:int(items_cnt * 0.9)]

        patron_sample = random.sample(list(Patron.objects.all()), int(patron_cnt * 0.3))  # 30% sample
        for item in items:
            # amount is between 100 - 115 % of the fmv
            amount = item.fair_market_value * Decimal(random.randint(100, 115) / 100.0)
            patron = random.choice(patron_sample)
            p = Purchase.purchase_item(patron=patron, amount=amount, item=item)
            minutes = 4 * 60 + random.randint(1, 4 * 60)  # spread purchases over 4 hours, later
            p.transaction_time = base_time + timezone.timedelta(minutes=minutes)
            p.save()
            print('i', end='')

        print("\nPurchases Done.")
