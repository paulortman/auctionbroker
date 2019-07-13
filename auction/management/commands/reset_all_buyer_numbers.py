from django.core.management.base import BaseCommand, CommandError

from auction.models import Patron


class Command(BaseCommand):
    help = 'Reset all Buyer Numbers to None'

    def handle(self, *args, **kwargs):
        for patron in Patron.objects.all():
            patron.buyer_num = None
            patron.save()

        print("All buyer numbers reset.")
