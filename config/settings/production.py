import dj_database_url
from .base import *


DEBUG = False

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases

DATABASES = {'default': dj_database_url.config(conn_max_age=600)}

MIDDLEWARE = [MIDDLEWARE[0], 'debug_toolbar.middleware.DebugToolbarMiddleware',].extend(MIDDLEWARE[1:])

STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'