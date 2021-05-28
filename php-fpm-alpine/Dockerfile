ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr>"
RUN apk --no-cache add php7 php7-fpm php7-opcache \
        php7-ctype php7-curl php7-dom php7-gd libgd php7-iconv php7-json \
        php7-mbstring php7-openssl php7-posix php7-session \
        php7-simplexml php7-xmlwriter php7-xmlreader php7-zip \
        php7-common php7-pdo_mysql php7-fileinfo php7-bz2 php7-intl \
        php7-ftp php7-bcmath php7-gmp php7-exif php7-pecl-apcu php7-pcntl \
        php7-pecl-imagick ffmpeg \
        freetype libpng libjpeg-turbo \
        libxml2 php7-xml

COPY start_fpm /usr/local/bin/
COPY 00-php-fpm.conf /etc/php7/php-fpm.d/
COPY 00-fpm-www.conf /etc/php7/php-fpm.d/
COPY 000-container-php.ini /etc/php7/conf.d/

RUN chmod 755 /usr/local/bin/start_fpm \
    && addgroup -g 82 www-data \
    && adduser -S -H -D -h /var/lib/php7 -s /sbin/nologin -u 82 -G www-data www-data \
    && mkdir -p /var/run/php7 /var/www/html \
    && mkdir -p /etc/php7/kube/php-conf.d /etc/php7/kube/fpm-conf.d \
    && ln -s /dev/stdout /var/log/php7/error.log \
    && ln -s /dev/stdout /var/log/php7/map_stdout.log \
    && chown -R www-data: /var/lib/php7 /var/run/php7 /var/log/php7 /var/www/html /etc/php7
 
USER 82

EXPOSE 9000

CMD ["start_fpm"]
