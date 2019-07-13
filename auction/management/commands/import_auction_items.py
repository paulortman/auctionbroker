import csv

from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from django.utils import timezone

from auction.models import AuctionItem, Booth


class Command(BaseCommand):
    help = 'Import Action items listing from tab separated file (TSV)'

    def add_arguments(self, parser):
        # Positional arguments
        parser.add_argument('auction_name', action='store', type=str)
        parser.add_argument('file', action='store', type=str)

        # Named (optional) arguments
        parser.add_argument('--year', action='store', type=int, default=timezone.now().year)
        parser.add_argument('--month', action='store', type=int, default=timezone.now().month)
        parser.add_argument('--day', action='store', type=int, default=timezone.now().day)

    def handle(self, *args, **kwargs):
        self.auction_name = kwargs['auction_name']
        self.file = kwargs['file']
        self.year = kwargs['year']
        self.month = kwargs['month']
        self.day = kwargs['day']

        auction = Booth.objects.get(name=self.auction_name)

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

                try:
                    description = row[2]
                except IndexError:
                    description = ''

                # interpret the short time into a real time
                time = row[0]
                hour, min = time.split(":")
                hour = int(hour)
                min = int(min)
                if hour < 9:
                    hour = hour + 12

                datetime = timezone.datetime(
                    year = self.year,
                    month = self.month,
                    day = self.day,
                    hour = hour,
                    minute = min)

                datetime_tz = timezone.make_aware(datetime, timezone=settings.SALE_TZ)

                yield {'time':datetime_tz, 'name':name, 'description':description}

