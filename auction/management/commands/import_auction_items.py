import csv

from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from django.utils import timezone

from auction.models import AuctionItem, Booth


class Command(BaseCommand):
    help = 'Import Action items listing from tab seperated file (TSV)'

    file = '2019_auction_items.tsv'
    time_year = 2019
    time_month = 7
    time_day = 13
    time_zone = ''

    def handle(self, *args, **kwargs):
        auction = Booth.objects.get(name='Auction')

        for item in self.get_item():
            AuctionItem.objects.create(
                name=item['name'],
                long_desc=item['description'],
                booth=auction,
                scheduled_sale_time=item['time'])
            print ("{} > {}".format(item['time'].strftime("%H:%m"), item['name']))

    def get_item(self):
        with open(self.file, 'r', encoding='utf-8-sig') as tsvfile:
            reader = csv.reader(tsvfile, delimiter='\t')
            for row in reader:
                name = row[1]
                description = row[2]

                # interpret the short time into a real time
                time = row[0]
                hour, min = time.split(":")
                hour = int(hour)
                min = int(min)
                if hour < 9:
                    hour = hour + 12

                datetime = timezone.datetime(
                    year = self.time_year,
                    month = self.time_month,
                    day = self.time_day,
                    hour = hour,
                    minute = min)

                datetime_tz = timezone.make_aware(datetime, timezone=settings.SALE_TZ)

                yield {'time':datetime_tz, 'name':name, 'description':description}

