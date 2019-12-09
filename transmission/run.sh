#!/bin/ash -xe
cp -rv /transmission_settings/*.json /config || true
/usr/bin/transmission-daemon --foreground --no-watch-dir --incomplete-dir=/downloads/incomplete --config-dir=/config --logfile=/dev/stdout --download-dir=/downloads/complete --log-error --log-info --pid-file=/tmp/transmission.pid $@
