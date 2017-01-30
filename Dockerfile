FROM praekeltfoundation/django-bootstrap

RUN apt-get-install.sh gettext

ENV PROJECT_ROOT=/app/ \
    DJANGO_SETTINGS_MODULE=babycenter.settings.docker \
    APP_MODULE="babycenter.wsgi:application"

ENV CELERY_APP babycenter
ENV CELERY_BEAT 1

COPY . /app

RUN pip install -e .

RUN LANGUAGE_CODE=en django-admin compilemessages && \
    django-admin compress && \
    django-admin collectstatic --noinput
