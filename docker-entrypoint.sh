#!/usr/bin/env bash
set -e

if [ $# -eq 0 ]; then
    if [ "$APACHE_SSL" == "1" ]; then
        /usr/sbin/a2enconf ssl.conf
        sed -i 's/*:80/*:443/' /etc/apache2/sites-available/app-host.conf
        sed -i 's/#SSLEngine On/SSLEngine On/' /etc/apache2/sites-available/app-host.conf
    fi

    # if no arguments are supplied start apache
    exec /usr/sbin/apache2ctl -DFOREGROUND
fi

exec "$@"