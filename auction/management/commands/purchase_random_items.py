from django.core.management.base import BaseCommand, CommandError

class Command(BaseCommand):
    help = 'Purchase a subset of all auction items and a number of purchased items'

    def handle(self, *args, **kwargs):
        pass
