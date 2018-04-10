FROM phusion/baseimage

RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y --force-yes install vim \
  nginx \
  python-dev \
  python-flup \
  python-pip \
  python-ldap \
  expect \
  git \
  memcached \
  sqlite3 \
  libffi-dev \
  libcairo2 \
  libcairo2-dev \
  python-cairo \
  python-rrdtool \
  pkg-config \
  nodejs \
  memcached \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# fix python dependencies (LTS Django and newer memcached/txAMQP)
RUN pip install django==1.8.18 \
  python-memcached==1.53 \
  txAMQP==0.6.2

# install whisper
RUN git clone -b 1.0.2 --depth 1 https://github.com/graphite-project/whisper.git /usr/local/src/whisper
WORKDIR /usr/local/src/whisper
RUN python ./setup.py install

# install carbon
RUN git clone -b 1.0.2 --depth 1 https://github.com/graphite-project/carbon.git /usr/local/src/carbon
WORKDIR /usr/local/src/carbon
RUN pip install -r requirements.txt \
  && python ./setup.py install

# install graphite
RUN git clone -b 1.0.2 --depth 1 https://github.com/graphite-project/graphite-web.git /usr/local/src/graphite-web
WORKDIR /usr/local/src/graphite-web
RUN pip install -r requirements.txt \
  && python ./setup.py install
ADD graphite/opt/graphite/conf/*.conf /opt/graphite/conf/
ADD graphite/opt/graphite/webapp/graphite/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
ADD graphite/opt/graphite/webapp/graphite/app_settings.py /opt/graphite/webapp/graphite/app_settings.py
WORKDIR /opt/graphite/webapp
RUN mkdir -p /var/log/graphite/ \
  && PYTHONPATH=/opt/graphite/webapp django-admin.py collectstatic --noinput --settings=graphite.settings

# Install BigGraphite
RUN pip install biggraphite

# config nginx
RUN rm /etc/nginx/sites-enabled/default
ADD graphite/etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD graphite/etc/nginx/sites-enabled/graphite-statsd.conf /etc/nginx/sites-enabled/graphite-statsd.conf

# init django admin
ADD graphite/usr/local/bin/django_admin_init.exp /usr/local/bin/django_admin_init.exp
ADD graphite/usr/local/bin/manage.sh /usr/local/bin/manage.sh
RUN chmod +x /usr/local/bin/manage.sh \
  && /usr/local/bin/django_admin_init.exp

# logging support
RUN mkdir -p /var/log/carbon /var/log/graphite /var/log/nginx
ADD graphite/etc/logrotate.d/graphite-statsd /etc/logrotate.d/graphite-statsd

# daemons
ADD graphite/etc/service/carbon/run /etc/service/carbon/run
ADD graphite/etc/service/graphite/run /etc/service/graphite/run
ADD graphite/etc/service/nginx/run /etc/service/nginx/run
ADD graphite/etc/service/memcached/run /etc/service/memcached/run

# default conf setup
#ADD conf /etc/graphite-statsd/conf
ADD graphite/etc/my_init.d/01_conf_init.sh /etc/my_init.d/01_conf_init.sh

# cleanup
RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# defaults
EXPOSE 80 2003-2004 2023-2024 8125/udp 8126
VOLUME ["/opt/graphite/conf", "/opt/graphite/storage", "/etc/nginx", "/etc/logrotate.d", "/var/log"]
WORKDIR /
ENV HOME /root
CMD ["/sbin/my_init"]
