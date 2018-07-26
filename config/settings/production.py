from .base import *
import dj_database_url


DEBUG = False

ALLOWED_HOSTS.append('auctionbroker.herokuapp.com')

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases

DATABASES = {'default': dj_database_url.config(conn_max_age=600, ssl_require=True)}

MIDDLEWARE = [MIDDLEWARE[0], 'whitenoise.middleware.WhiteNoiseMiddleware', ] + MIDDLEWARE[1:]

STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Force SSL on Heroku: https://help.heroku.com/J2R1S4T8/can-heroku-force-an-application-to-use-ssl-tls
SECURE_SSL_REDIRECT = True
