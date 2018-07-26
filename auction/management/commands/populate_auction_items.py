import csv
import pytz

from django.core.management.base import BaseCommand, CommandError
from django.utils import timezone

from auction.models import AuctionItem, Booth



class Command(BaseCommand):
    help = 'Populate the main auction items with the contents of a CSV files'

    tz = tzinfo=pytz.timezone('US/Central')
    dt = timezone.datetime(year=2018, month=8, day=28, hour=12, minute=00)

    def handle(self, *args, **kwargs):

        for i in AuctionItem.objects.filter(category=AuctionItem.MAIN):
            i.delete()

        auction = Booth.objects.get(name='Auction')
        csv.register_dialect('our_tsv', delimiter='\t', skipinitialspace=True)
        with open('sale_items.csv', newline='', encoding='utf-8-sig') as csvfile:
            reader = csv.reader(csvfile, dialect='our_tsv')
            for row in reader:
                print (row)
                rawtime, title, description = row[0], row[1], row[2]
                hour, minute = rawtime.split(':')
                hour, minute = int(hour), int(minute)
                if hour < 12:
                    hour = hour + 12
                item_number = "{:02d}{:02d}".format(hour, minute)
                time = self.dt.replace(hour=hour, minute=minute)
                print (time.strftime('%c %Z'))
                AuctionItem.objects.create(booth=auction,
                                           name=title,
                                           scheduled_sale_time=timezone.make_aware(time, self.tz),
                                           item_number=item_number,
                                           long_desc=description,
                                           category=AuctionItem.MAIN)

        print("\nPopulation Done")
