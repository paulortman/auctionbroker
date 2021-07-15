import sentry_sdk
from sentry_sdk.integrations.django import DjangoIntegration

from .base import *


DEBUG = False

ALLOWED_HOSTS.append('auctionbroker.herokuapp.com')


MIDDLEWARE = [MIDDLEWARE[0], 'whitenoise.middleware.WhiteNoiseMiddleware', ] + MIDDLEWARE[1:]

STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Force SSL on Heroku: https://help.heroku.com/J2R1S4T8/can-heroku-force-an-application-to-use-ssl-tls
SECURE_SSL_REDIRECT = True

# Configure Django App for Heroku.
import django_heroku

django_heroku.settings(locals())


# Sentry
sentry_sdk.init(
    dsn="https://206edf948b6a4381bcd295e0be7dda57@o528023.ingest.sentry.io/5866008",
    integrations=[DjangoIntegration()],

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    traces_sample_rate=1.0,

    # If you wish to associate users to errors (assuming you are using
    # django.contrib.auth) you may enable sending PII data.
    send_default_pii=True
)