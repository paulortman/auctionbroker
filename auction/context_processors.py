from auction.models import Booth


def site_vars(request):
    priced_booths = Booth.objects.filter(category=Booth.PRICED)
    auction_booths = Booth.objects.filter(category=Booth.AUCTION)
    context = {
        'priced_booths': priced_booths,
        'auction_booths': auction_booths
    }
    return context