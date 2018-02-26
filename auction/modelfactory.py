import random

from decimal import Decimal
from django.utils import timezone
from django.conf import settings

from .models import Buyer, Booth, AuctionItem
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


class AuctionItemFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = AuctionItem

    name = factory.Sequence(lambda n: 'item %d' % n)
    booth = factory.SubFactory(BoothFactory)
    long_desc = factory.Faker('paragraph')
    scheduled_sale_time = factory.Sequence(lambda n: timezone.now() + timezone.timedelta(minutes=5 * n))
    fair_market_value = factory.LazyFunction(lambda: Decimal("{}.00".format(random.randint(10, 800))))

