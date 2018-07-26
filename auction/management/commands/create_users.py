import random

from django.contrib.auth.models import User, Group, Permission
from django.core.management.base import BaseCommand, CommandError

class Command(BaseCommand):
    help = 'Create a bunch of users and groups'

    def handle(self, *args, **kwargs):

        # checkout
        baked, created = User.objects.get_or_create(username='baked', email='baked@example.com', first_name="Baked", last_name="Goods", is_staff=True)
        food, created = User.objects.get_or_create(username='food', email='food@example.com', first_name="Food", last_name="Court", is_staff=True)
        crafts, created = User.objects.get_or_create(username='crafts', email='crafts@example.com', first_name="Crafts", is_staff=True)
        produce, created = User.objects.get_or_create(username='produce', email='crafts@example.com', first_name="Crafts", is_staff=True)

        # auction related
        auction, created = User.objects.get_or_create(username='auction', email='auction@example.com', first_name="Auction", is_staff=True)
        bidding, created = User.objects.get_or_create(username='bidding', email='bidding@example.com', first_name="Bidding", is_staff=True)

        # account, settlement
        accounts, created = User.objects.get_or_create(username='accounts', email='accounts@example.com', first_name="Accounts", is_staff=True)

        checkout_g, created = Group.objects.get_or_create(name='checkout')
        auction_g, created = Group.objects.get_or_create(name='auction_managers')
        accounts_g, created = Group.objects.get_or_create(name='account_managers')
        admin_g, created = Group.objects.get_or_create(name='admins')

        for user in [baked, food, crafts, produce]:
            user.groups.add(checkout_g)

        for user in [auction, bidding]:
            user.groups.add(auction_g)

        accounts.groups.add(accounts_g)

        portman, created = User.objects.get_or_create(username='portman', email='paul.ortman@gmail.com', first_name='Paul',
                                             last_name='Ortman', is_staff=True, is_superuser=True)

        portman.groups.set([checkout_g, auction_g, accounts_g, admin_g])

        all_users = [baked, food, crafts, produce, auction, bidding, accounts, portman]
        for user in all_users:
            user.set_password(r'pass')
            user.save()

        print("Created Users: {}".format(', '.join([str(u) for u in all_users])))
