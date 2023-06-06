FROM quay.io/simbelmas/alpine:latest@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11

LABEL maintainer "Simon Belmas <slos@soket.fr>"
RUN apk --no-cache add nginx nginx-mod-http-geoip nginx-mod-http-xslt-filter nginx-mod-http-image-filter tzdata

#Configure logs and unprivileged access to files
RUN sed '2i pid /tmp/nginx.pid;' -i /etc/nginx/nginx.conf \
    && sed -r 's/^(user .*$)/#\1/g' -i /etc/nginx/nginx.conf \
    && sed -r 's/^(.*listen.*)80(.*)$/\18080\2/g' -i /etc/nginx/http.d/default.conf \
    && sed -r 's#^error_log.*$#error_log /dev/stdout warn;#g' -i /etc/nginx/nginx.conf \
    && sed -r 's#^([\t ]*access_log).*$#\1 /dev/stdout main;#g' -i  /etc/nginx/nginx.conf \
    && mkdir -p /var/tmp/nginx /etc/nginx/kube


COPY start_nginx /usr/local/bin
COPY site-default.conf /etc/nginx/http.d/default.conf

RUN adduser -S -H -D -h /home/nginx -s /sbin/nologin -u 82 www-data \
    && chown -R www-data: /var/tmp/nginx /etc/nginx \
    && chown root: /var/lib/nginx -R \
    && chmod a+rX /var/lib/nginx -R \
    && chmod a+rw /var/lib/nginx/tmp \
    && chmod 755 /usr/local/bin/start_nginx


USER 82

EXPOSE 8080

STOPSIGNAL SIGTERM

CMD ["start_nginx"]

