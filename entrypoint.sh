#!/bin/bash
set -e

exec gosu /usr/sbin/apache2ctl -D FOREGROUND

exec "$@"