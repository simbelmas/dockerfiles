FROM docker.io/php:fpm-alpine
LABEL maintainer "Simon Belmas <slos@soket.fr"
RUN apk --no-cache add -t build gcc g++ autoconf libpng-dev make \
    && apk --no-cache add libpng tzdata \
    && docker-php-source extract \
    && yes '' | pecl install apcu \
    && docker-php-ext-install gd \
    && docker-php-ext-enable apcu gd \
    && docker-php-source delete \
    && apk del build

#configmap additional directory for php.conf directory
RUN mkdir /usr/local/etc/php/configmap.d
COPY includeconfigmap_dir.ini /usr/local/etc/php/conf.d/

USER 82
