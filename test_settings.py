from babycenter.settings import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'babycenter_test.db',
    }
}

DEBUG = True
CELERY_ALWAYS_EAGER = True
