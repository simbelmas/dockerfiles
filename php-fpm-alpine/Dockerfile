FROM docker.io/php:fpm-alpine
LABEL maintainer "Simon Belmas <slos@soket.fr"
RUN apk --no-cache add -t build gcc g++ autoconf libpng-dev make \
    && apk --no-cache add libpng tzdata \
    && docker-php-source extract \
    && yes '' | pecl install apcu \
    && docker-php-ext-install gd \
    && docker-php-ext-enable apcu gd \
    && docker-php-source delete \
    && apk del build \
    && ln -s /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed 's#;include_path = ".:/php/includes"#include_path="\.:/usr/local/etc/php/configmap.d"#' -i /usr/local/etc/php/php.ini-production


#configmap additional directory for php.conf directory
RUN mkdir /usr/local/etc/php/configmap.d

USER 82
