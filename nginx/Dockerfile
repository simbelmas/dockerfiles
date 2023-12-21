FROM quay.io/simbelmas/ubuntu:v2310.13@sha256:751f4ce0a66b502e58fd568dc931d6bfb292f8c2cc02b71e198cd5883ae1ee73

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    ## Install packages
    && apt-get -y install libnginx-mod-http-geoip libnginx-mod-http-xslt-filter libnginx-mod-http-image-filter tzdata \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/* \
    
    ## remove ubuntu defauts dirs for sites management
    && rm -rf /etc/nginx/sites-enabled /etc/nginx/sites-available \

    ## add user and change directory permissions
    && useradd -d /var/www -s /sbin/nologin -u 1001 app \
    && mkdir /var/lib/nginx/tmp /etc/nginx/kube \
    && mv /var/www/html/index.nginx-debian.html /var/www/html/index.html \
    && chown -R app: /etc/nginx /var/www \
    && chmod a+rw /var/lib/nginx/tmp \
    && chmod a+rX /var/lib/nginx \

    #Configure logs and unprivileged access to files
    && sed 's#^pid.*$#pid /tmp/nginx.pid;#' -i /etc/nginx/nginx.conf \
    && sed -r 's/^(user .*$)/#\1/g' -i /etc/nginx/nginx.conf \
    && sed -r 's#^error_log.*$#error_log /dev/stdout warn;#g' -i /etc/nginx/nginx.conf \
    && sed -r 's#^([\t ]*access_log).*$#\1 /dev/stdout combined;#g' -i  /etc/nginx/nginx.conf \
    && sed -r 's#.*include.*sites-enabled.*$##' -i /etc/nginx/nginx.conf \
    && sed -r 's/([\t ]*)#.*(server_tokens ).*$/\1\2off;/' -i /etc/nginx/nginx.conf \

    #Point to kube configuration in /etc/kube to avoid giving permissions to all users to /etc/nginx/conf.d
    && ln -sf /etc/nginx/kube/default.conf /etc/nginx/conf.d/default.conf 

COPY site-default.conf /etc/nginx/kube/default.conf
COPY temp-dir.conf /etc/nginx/conf.d/00-temp-dir.conf

WORKDIR /var/www
USER 1001

EXPOSE 8080

STOPSIGNAL SIGTERM

ENTRYPOINT ["nginx", "-g", "daemon off;"]


