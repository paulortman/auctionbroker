from django.core.management.base import BaseCommand, CommandError

from auction.modelfactory import BoothFactory
class Command(BaseCommand):
    help = 'Create the standard booths'

    def handle(self, *args, **kwargs):
        BoothFactory.create(name='Baked Goods')
        BoothFactory.create(name='Produce')
        BoothFactory.create(name='Crafts')
        BoothFactory.create(name='Etc Shoppe')
        BoothFactory.create(name='Tickets')

        BoothFactory.create(name='Auction')

        print("\nPopulation Done")
