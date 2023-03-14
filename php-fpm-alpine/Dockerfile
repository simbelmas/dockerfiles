FROM quay.io/simbelmas/alpine:latest@sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517

ARG php_version=81

LABEL maintainer "Simon Belmas <slos@soket.fr>"
RUN apk --no-cache add php${php_version} php${php_version}-fpm php${php_version}-opcache \
        php${php_version}-ctype php${php_version}-curl php${php_version}-dom php${php_version}-gd libgd php${php_version}-iconv php${php_version}-json \
        php${php_version}-mbstring php${php_version}-openssl php${php_version}-posix php${php_version}-session \
        php${php_version}-simplexml php${php_version}-xmlwriter php${php_version}-xmlreader php${php_version}-zip \
        php${php_version}-common php${php_version}-pdo_mysql php${php_version}-fileinfo php${php_version}-bz2 php${php_version}-intl \
        php${php_version}-ftp php${php_version}-bcmath php${php_version}-gmp php${php_version}-exif php${php_version}-pecl-apcu php${php_version}-pcntl php${php_version}-phar \
        php${php_version}-pecl-imagick ffmpeg \
        curl \
        freetype libpng libjpeg-turbo \
        libxml2 php${php_version}-xml

COPY start_fpm /usr/local/bin/
COPY run_php_command /usr/local/bin/
COPY 00-php-fpm.conf /etc/php${php_version}/php-fpm.d/
COPY 00-fpm-www.conf /etc/php${php_version}/php-fpm.d/
COPY 000-container-php.ini /etc/php${php_version}/conf.d/

RUN sed "s/PHP_VERSION/${php_version}/g" -i /usr/local/bin/start_fpm \
    && sed "s/PHP_VERSION/${php_version}/g" -i /usr/local/bin/run_php_command \ 
    && if [ ! -e /usr/bin/php ] ; then ln -s /usr/bin/php${php_version} /usr/bin/php ; fi

RUN chmod 755 /usr/local/bin/start_fpm /usr/local/bin/run_php_command \
    && adduser -S -H -D -h /var/lib/php${php_version} -s /sbin/nologin -u 82 -G www-data www-data \
    && mkdir -p /var/run/php /var/www/html \
    && mkdir -p /etc/phpkube/php-conf.d /etc/phpkube/fpm-conf.d \
    && chown -R www-data: /var/run/php /var/lib/php${php_version} /var/log/php${php_version} /var/www/html /etc/php${php_version} /etc/phpkube
 
USER 82

EXPOSE 9000

CMD ["start_fpm"]
