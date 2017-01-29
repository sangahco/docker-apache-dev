FROM debian:jessie
MAINTAINER Emanuele Disco <emanuele.disco@gmail.com>

RUN apt-get update && apt-get -y install \
    apache2 \
    libapache2-mod-jk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

COPY . /setup

RUN set -x \
    && cp /setup/workers.properties /etc/libapache2-mod-jk \
    && cp /setup/app-host.conf /etc/apache2/sites-available \
    && cp /setup/default-host.conf /etc/apache2/sites-available \
    && cp /setup/jk.conf /etc/apache2/conf-available \
    && cp /setup/ssl.conf /etc/apache2/conf-available \
    && cp /setup/upload.conf /etc/apache2/conf-available \
    && mkdir -p /etc/pki/tls/app/ \
    && /usr/sbin/a2ensite default-ssl \
    && /usr/sbin/a2enmod ssl \
    && /usr/sbin/a2enmod proxy \
    && /usr/sbin/a2enmod proxy_http \
    && /usr/sbin/a2ensite app-host.conf \
    #&& /usr/sbin/a2ensite default-host.conf \
    #&& /usr/sbin/a2enconf jk.conf \
    #&& /usr/sbin/a2enconf ssl.conf \
    && /usr/sbin/a2dissite 000-default.conf \
    && ln -s /var/log/apache2 /etc/apache2/logs \
    && cp /setup/docker-entrypoint.sh /entrypoint.sh \
    && if [ -d "/setup/tls" ]; then cp /setup/tls/* /etc/pki/tls/app; fi \
    # final step remove setup folder
    && rm -rf /setup

VOLUME /var/log/apache2

EXPOSE 80
EXPOSE 443

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#CMD ["/bin/bash"]