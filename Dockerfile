FROM dev.sangah.com:5043/apache-base
MAINTAINER Emanuele Disco <emanuele.disco@gmail.com>

COPY . /usr/local/src/
WORKDIR /usr/local/src

RUN set -x && \
    cp conf.d/workers.properties /etc/libapache2-mod-jk && \
    cp conf.d/app-host.conf /etc/apache2/sites-available && \
    cp conf.d/upload.conf /etc/apache2/conf-available && \
    cp conf.d/ssl.conf /etc/apache2/conf-available && \
    /usr/sbin/a2ensite app-host.conf && \
    /usr/sbin/a2enconf upload.conf && \

    # attach the log to stdout
    ln -sf /proc/self/fd/1 /var/log/apache2/app-access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/app-error.log && \

    cp docker-entrypoint.sh /entrypoint.sh && \
    rm -rf /usr/local/src

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]