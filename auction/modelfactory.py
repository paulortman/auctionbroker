import random

from django.utils import timezone
from djmoney.money import Money
from django.conf import settings

from .models import Buyer, Booth
from .models import Item
import factory


class BuyerFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Buyer

    name = factory.Faker('name')
    buyer_num = factory.Sequence(lambda n: "{}".format(settings.BASE_BUYER_NUMBER + n))


class BoothFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Booth

    name = factory.Sequence(lambda n: 'booth %d' % n)


class ItemFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Item

    name = factory.Sequence(lambda n: 'item %d' % n)
    booth = factory.SubFactory(BoothFactory)
    long_desc = factory.Faker('paragraph')
    scheduled_sale_time = factory.Sequence(lambda n: timezone.now() + timezone.timedelta(minutes=5 * n))
    fair_market_value = factory.LazyFunction(lambda: Money("{}.00".format(random.randint(10, 800), 'USD')))

