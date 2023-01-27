FROM quay.io/simbelmas/alpine:latest@sha256:b95359c2505145f16c6aa384f9cc74eeff78eb36d308ca4fd902eeeb0a0b161b

LABEL maintainer "Simon Belmas <slos@soket.fr>"
RUN apk --no-cache add nginx nginx-mod-http-geoip nginx-mod-http-xslt-filter nginx-mod-http-image-filter tzdata

#Configure logs and unprivileged access to files
RUN sed '2i pid /tmp/nginx.pid;' -i /etc/nginx/nginx.conf \
    && sed -r 's/^(user .*$)/#\1/g' -i /etc/nginx/nginx.conf \
    && sed -r 's/^(.*listen.*)80(.*)$/\18080\2/g' -i /etc/nginx/http.d/default.conf \
    && ln -s /dev/stdout /var/log/nginx/access.log \
    && if [ -e '/var/lib/nginx/logs/access.log' ] ; then rm -v /var/lib/nginx/logs/access.log ; fi \
    && ln -s /dev/stdout /var/lib/nginx/logs/access.log \
    && ln -s /dev/stderr /var/lib/nginx/logs/error.log \
    && if [ -e "/var/log/nginx/error.log" ] ; then rm -v /var/log/nginx/error.log ; fi \
    && ln -s /dev/stderr /var/log/nginx/error.log \
    && mkdir -p /var/tmp/nginx /etc/nginx/kube


COPY start_nginx /usr/local/bin
RUN adduser -S -H -D -h /var/lib/nginx -s /sbin/nologin -u 82 www-data \
    && chown -R www-data: /var/lib/nginx /var/tmp/nginx /etc/nginx \
    && chmod 755 /usr/local/bin/start_nginx


USER 82

EXPOSE 8080

STOPSIGNAL SIGTERM

CMD ["start_nginx"]

