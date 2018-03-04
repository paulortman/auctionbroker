from .base import *


DEBUG = True

INSTALLED_APPS.extend([
    'debug_toolbar',
])

MIDDLEWARE = ['debug_toolbar.middleware.DebugToolbarMiddleware',].extend(MIDDLEWARE)

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
