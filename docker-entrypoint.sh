#!/bin/bash
set -e

if [ "$APACHE_SSL" -eq "1" ]; then
    echo "Executing Apache with SSL" 
    /usr/sbin/a2enconf ssl.conf; 
else
    echo "Executing Apache without SSL"
fi

if [ $# -eq 0 ]; then
# if no arguments are supplied start apache
    exec /usr/sbin/apache2ctl -DFOREGROUND
fi

exec "$@"