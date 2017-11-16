from .models import Buyer, Booth
from .models import Item
import factory


class BuyerFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Buyer

    name = factory.Faker('name')


class BoothFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Booth

    name = factory.Sequence(lambda n: 'booth %d' % n)


class ItemFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Item

    name = factory.Sequence(lambda n: 'item %d' % n)
    booth = factory.SubFactory(BoothFactory)
