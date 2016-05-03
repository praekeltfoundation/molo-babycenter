FROM ubuntu:14.04
MAINTAINER Milton Madanda <milton@praekelt.com>
RUN apt-get update && apt-get -y --force-yes install libjpeg-dev zlib1g-dev libxslt1-dev libpq-dev nginx supervisor python-dev python-pip
RUN apt-get install libffi-dev

RUN pip install --upgrade pip

ENV PROJECT_ROOT /deploy/
ENV DJANGO_SETTINGS_MODULE babycenter.settings.docker

WORKDIR /deploy/

COPY babycenter /deploy/babycenter
ADD manage.py /deploy/
ADD requirements.txt /deploy/
ADD setup.py /deploy/
ADD README.rst /deploy/
ADD VERSION /deploy/

RUN pip install -e .

RUN mkdir -p /etc/supervisor/conf.d/
RUN mkdir -p /var/log/supervisor
RUN rm /etc/nginx/sites-enabled/default

ADD docker/nginx.conf /etc/nginx/sites-enabled/molo.conf
ADD docker/supervisor.conf /etc/supervisor/conf.d/molo.conf
ADD docker/supervisord.conf /etc/supervisord.conf
ADD docker/docker-start.sh /deploy/
ADD docker/settings.py /deploy/babycenter/settings/docker.py

RUN chmod a+x /deploy/docker-start.sh

EXPOSE 80

ENTRYPOINT ["/deploy/docker-start.sh"]