FROM dev.sangah.com:5043/apache-base
MAINTAINER Emanuele Disco <emanuele.disco@gmail.com>

COPY . /setup

RUN set -x \
    && cp /setup/workers.properties /etc/libapache2-mod-jk \
    && cp /setup/app-host.conf /etc/apache2/sites-available \
    && cp /setup/upload.conf /etc/apache2/conf-available \
    && /usr/sbin/a2ensite app-host.conf \
    # final step remove setup folder
    && rm -rf /setup