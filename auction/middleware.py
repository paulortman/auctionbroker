import pytz
from django.conf import settings

from django.utils import timezone
from django.utils.deprecation import MiddlewareMixin

class TimezoneMiddleware(MiddlewareMixin):
    def process_request(self, request):
        # tzname = request.session.get('django_timezone')
        #
        # if tzname:
        #     timezone.activate(pytz.timezone(tzname))
        # else:
        #     timezone.deactivate()

        timezone.activate(settings.SALE_TZ)