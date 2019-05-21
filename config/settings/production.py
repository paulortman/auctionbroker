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