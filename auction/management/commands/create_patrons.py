from django.core.management.base import BaseCommand, CommandError

from auction.modelfactory import PatronFactory


class Command(BaseCommand):
    help = 'Create the standard booths'

    def handle(self, *args, **kwargs):

        patron_cnt = 50

        for patron in range(0, patron_cnt):
            PatronFactory.create()

        print("\nPopulation Done")
