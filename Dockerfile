FROM debian:jessie
MAINTAINER Emanuele Disco <emanuele.disco@gmail.com>

RUN apt-get update && apt-get -y install \
    apache2 \
    libapache2-mod-jk \
    nano \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

COPY ./workers.properties /etc/libapache2-mod-jk/
COPY ./app-host.conf /etc/apache2/sites-available/
COPY ./default-host.conf /etc/apache2/sites-available/
COPY ./jk.conf /etc/apache2/conf-available/
COPY ./ssl.conf /etc/apache2/conf-available/

RUN set -x \
    && /usr/sbin/a2ensite default-ssl \
    && /usr/sbin/a2enmod ssl \
    && /usr/sbin/a2ensite app-host.conf \
    #&& /usr/sbin/a2ensite default-host.conf \
    #&& /usr/sbin/a2enconf jk.conf \
    #&& /usr/sbin/a2enconf ssl.conf \
    && /usr/sbin/a2dissite 000-default.conf \
    && ln -s /var/log/apache2 /etc/apache2/logs \
    && mkdir /app \
    && mkdir -p /etc/pki/tls/kspmis/

COPY ./tls/_wildcard_kspmis_com.crt /etc/pki/tls/kspmis/
COPY ./tls/_wildcard_kspmis_com_SHA256WITHRSA.key /etc/pki/tls/kspmis/
COPY ./tls/rsa-dv.chain-bundle.pem /etc/pki/tls/kspmis/

COPY index.html /app
VOLUME /app
VOLUME /var/log/apache2

EXPOSE 80
EXPOSE 443

#COPY entrypoint.sh /
#ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]