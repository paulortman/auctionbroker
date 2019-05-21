import random

from django.core.management.base import BaseCommand, CommandError

from auction.modelfactory import BoothFactory, PatronFactory, AuctionItemFactory
from auction.models import AuctionItem, Booth

items = [
    "1945 Massey Harris",
    "1952 MG Sports Car",
    "1965 Chevy 60 Farm Truck With Hoist",
    "1968 F-100 Ford Pickup",
    "1988 S-10 Chevy Pickup",
    "1993 Honda Helix",
    "A-C toy tractor and John Deere metal sign",
    "Antique Hall Tree",
    "Antique Oak Buffet",
    "Bamboo Rocking Horse",
    "Catered Pork Chop Meal",
    "Child’s Rocker",
    "FOUR Meal Deals for up to 25 people",
    "FarmersEdge Service",
    "Hand Crafted Adirondack Chairs",
    "Hustler MDV LeveLift",
    "L111 John Deere Hydrostatic Mower",
    "LARGE 36 Inch Life Like Dolls",
    "Mowers, Blower, Edger & Power Tools",
    "Mudroom Storage Bench",
    "Professionally Restored 1950 8N Ford Tractor",
    "Quilt Rack",
    "Quilters Diorama/Shadowbox",
    "Restored 1949 Schwinn Black Phantom Bicycle",
    "Schwinn Bicycle",
    "Smart VR",
    "Vintage 110 John Deere ",
    "bamboo rocking horse",
    "mudroom storage bench",
    "StarBurst Quilt",
    "Children's Quilt",
    "Chocolate Heaven"
]

class Command(BaseCommand):
    help = 'Create a bunch of test stuff in the DB'

    def handle(self, *args, **kwargs):
        # BoothFactory.objects.get_or_create(name='Baked Goods')
        # BoothFactory.get_or_create(name='Food Court')
        # BoothFactory.get_or_create(name='Crafts')
        auction = Booth.objects.get(name='Auction')
        silent_auction = Booth.objects.get(name='Silent Auction')

        random.shuffle(items)
        for i in items:
            if random.randrange(1,10,1) < 9:
                AuctionItemFactory.create(booth=auction, name=i)
                print('M', end='')
            else:
                AuctionItemFactory.create(booth=silent_auction, name=i)
                print('S', end='')

        print("\nPopulation Done")
