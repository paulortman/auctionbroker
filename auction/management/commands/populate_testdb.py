from django.core.management.base import BaseCommand, CommandError

from auction.modelfactory import BoothFactory, BuyerFactory, ItemFactory


class Command(BaseCommand):
    help = 'Create a bunch of test stuff in the DB'

    def handle(self, *args, **kwargs):
        BoothFactory.create(name='Baked Goods')
        BoothFactory.create(name='Silent Auction')
        BoothFactory.create(name='Food Court')
        BoothFactory.create(name='Crafts')
        auction = BoothFactory.create(name='Auction')

        for i in range(200):
            BuyerFactory.create()

        for i in range(50):
            ItemFactory.create(booth=auction)

