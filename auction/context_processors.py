from auction.models import Booth


def site_vars(request):
    booths = Booth.objects.exclude(name__iexact='auction')
    context = {
        'booths': booths
    }
    return context