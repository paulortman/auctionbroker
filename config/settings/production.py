from .base import *
import dj_database_url


DEBUG = False

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases

DATABASES = {'default': dj_database_url.config(conn_max_age=600, ssl_require=True)}

MIDDLEWARE = [MIDDLEWARE[0], 'whitenoise.middleware.WhiteNoiseMiddleware', ] + MIDDLEWARE[1:]

STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'