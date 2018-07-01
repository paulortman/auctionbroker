from django.utils.text import slugify
from auction.models import Booth, AuctionItem


def site_vars(request):
    booths = Booth.objects.exclude(name__iexact='auction')
    auction_categories = list(map(slugify, AuctionItem.categories()))
    context = {
        'booths': booths,
        'auction_categories': auction_categories
    }
    return context