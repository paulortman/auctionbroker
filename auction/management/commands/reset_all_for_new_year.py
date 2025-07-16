from django.core.management.base import BaseCommand, CommandError

from auction.models import Patron, AuctionItem, Payment, Fee, Purchase


class Command(BaseCommand):
    help = 'Delete all Auction Items to None'

    def handle(self, *args, **kwargs):
        AuctionItem.objects.all().delete()
        Payment.objects.all().delete()
        Fee.objects.all().delete()
        Purchase.objects.all().delete()

        print("All auction items, payments, fees, purchases deleted")
