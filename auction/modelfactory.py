from .models import Bidder
from .models import AuctionItem
import factory


class BidderFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Bidder

    name = factory.Faker('name')
