from django.core.management.base import BaseCommand, CommandError

from auction.modelfactory import BoothFactory
from auction.models import Booth


class Command(BaseCommand):
    help = 'Create the standard booths'

    def handle(self, *args, **kwargs):
        BoothFactory.create(name='Baked Goods', category=Booth.PRICED)
        BoothFactory.create(name='Produce', category=Booth.PRICED)
        BoothFactory.create(name='Crafts', category=Booth.PRICED)
        BoothFactory.create(name='Etc Shoppe', category=Booth.PRICED)
        BoothFactory.create(name='Noon Food', category=Booth.PRICED)
        BoothFactory.create(name='Breakfast Food', category=Booth.PRICED)
        BoothFactory.create(name='Schoolkits', category=Booth.PRICED)

        BoothFactory.create(name='Auction', category=Booth.AUCTION)
        BoothFactory.create(name='Silent Auction', category=Booth.AUCTION)

        print("\nPopulation Done")
