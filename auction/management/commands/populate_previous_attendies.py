import csv

from django.core.management.base import BaseCommand

from auction.models import Patron

class Command(BaseCommand):
    help = 'Add patrons listed in the attendies.csv file'

    def handle(self, *args, **kwargs):

        with open('attendies.csv', 'r') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                Patron.objects.create(first_name = row['First_Name'],
                                      last_name = row['Last_Name'],
                                      email = row['Email'],
                                      address_line1 = row['Address1'],
                                      address_line2 = row['Address2'],
                                      address_line3 = row['Address3'],
                                      phone1 = row['Phone'])
