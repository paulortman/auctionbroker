from auction.models import Booth


def site_vars(request):
    booths = Booth.objects.all()
    context = {
        'booths': booths
    }
    return context