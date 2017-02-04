FROM dev.sangah.com:5043/apache-base
MAINTAINER Emanuele Disco <emanuele.disco@gmail.com>

COPY . /setup

RUN set -x \
    && cp /setup/workers.properties /etc/libapache2-mod-jk \
    && cp /setup/app-host.conf /etc/apache2/sites-available \
    && cp /setup/upload.conf /etc/apache2/conf-available \
    && cp /setup/ssl.conf /etc/apache2/conf-available \

    && /usr/sbin/a2ensite app-host.conf \
    && /usr/sbin/a2enconf upload.conf \
    && cp /setup/docker-entrypoint.sh /entrypoint.sh \
    && rm -rf /setup

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]