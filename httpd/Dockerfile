FROM dev.sangah.com:5043/apache-base:0.1
MAINTAINER Emanuele Disco <emanuele.disco@gmail.com>

COPY . /usr/local/src/
WORKDIR /usr/local/src

ENV APACHE_SSL=0 \
    APACHE_SSL_KEY=key.pem \
    APACHE_SSL_CERT=cert.pem \
    SECURED_RESOURCE_ALLOWED_IP=127.0.0.1

RUN set -x && \
    cp conf.d/workers.properties /etc/libapache2-mod-jk && \
    cp conf.d/app-host.conf /etc/apache2/sites-available && \
    cp conf.d/upload.conf /etc/apache2/conf-available && \
    cp conf.d/ssl.conf /etc/apache2/conf-available && \
    /usr/sbin/a2ensite app-host.conf && \
    /usr/sbin/a2enconf upload.conf && \
    # attach the log to stdout
    ln -sf /proc/self/fd/1 ${APACHE_LOG_DIR}/app-access.log && \
    ln -sf /proc/self/fd/1 ${APACHE_LOG_DIR}/app-error.log

ARG SYSCONF=1.0.1
ADD https://github.com/sangahco/pmis-system-config/releases/download/v${SYSCONF}/sysconf-v${SYSCONF}.tar.gz sysconf.tar.bz2
RUN set -x && \
    tar -xf sysconf.tar.bz2 && \
    mkdir -p /usr/local/share/sysconf && \
    cp -a sysconf*/. /usr/local/share/sysconf/

RUN cp docker-entrypoint.sh /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    rm -rf /usr/local/src

ENTRYPOINT ["/entrypoint.sh"]