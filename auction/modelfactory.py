import random

from decimal import Decimal
from django.utils import timezone
from django.conf import settings

from .models import Patron, Booth, AuctionItem, round_scheduled_sale_time
import factory


def fake_address_line2():
    cities = ['Freeman', 'Marion', 'Parker', 'Hurley', 'Bridgewater', 'Emery', 'Menno']
    city = random.choice(cities)
    return "{city}, SD".format(city=city)

class PatronFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Patron

    first_name = factory.Faker('first_name')
    last_name = factory.Faker('last_name')
    email = factory.Faker('email')
    address_line1 = factory.Faker('street_address')
    address_line2 = factory.LazyFunction(fake_address_line2)
    address_line3 = factory.Faker('zipcode')
    phone1 = factory.Faker('phone_number')
    buyer_num = factory.Sequence(lambda n: "{}".format(settings.BASE_BUYER_NUMBER + n))


class BoothFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Booth

    name = factory.Sequence(lambda n: 'booth %d' % n)


class AuctionItemFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = AuctionItem

    name = factory.Sequence(lambda n: 'item %d' % n)
    booth = factory.SubFactory(BoothFactory)
    long_desc = factory.Faker('paragraph')
    scheduled_sale_time = factory.Sequence(lambda n: round_scheduled_sale_time(timezone.now() + timezone.timedelta(minutes=settings.AUCTIONITEM_SCHEDULED_TIME_INCREMENT * n)))
    fair_market_value = factory.LazyFunction(lambda: Decimal("{}.00".format(random.randint(10, 800))))

