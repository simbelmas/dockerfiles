FROM docker.io/alpine:latest

LABEL maintainer "Simon Belmas <slos@soket.fr>"
RUN apk --no-cache add php8 php8-fpm php8-opcache \
        php8-ctype php8-curl php8-dom php8-gd libgd php8-iconv php8-json \
        php8-mbstring php8-openssl php8-posix php8-session \
        php8-simplexml php8-xmlwriter php8-xmlreader php8-zip \
        php8-common php8-pdo_mysql php8-fileinfo php8-bz2 php8-intl \
        php8-ftp php8-bcmath php8-gmp php8-exif php8-pecl-apcu php8-pcntl \
        php8-pecl-imagick ffmpeg \
        freetype libpng libjpeg-turbo \
        libxml2 php8-xml

COPY start_fpm /usr/local/bin/
COPY run_php_command /usr/local/bin/
COPY 00-php-fpm.conf /etc/php8/php-fpm.d/
COPY 00-fpm-www.conf /etc/php8/php-fpm.d/
COPY 000-container-php.ini /etc/php8/conf.d/

RUN chmod 755 /usr/local/bin/start_fpm /usr/local/bin/run_php_command \
    && adduser -S -H -D -h /var/lib/php8 -s /sbin/nologin -u 82 -G www-data www-data \
    && mkdir -p /var/run/php8 /var/www/html \
    && mkdir -p /etc/php8/kube/php-conf.d /etc/php8/kube/fpm-conf.d \
    && chown -R www-data: /var/lib/php8 /var/run/php8 /var/log/php8 /var/www/html /etc/php8
 
USER 82

EXPOSE 9000

CMD ["start_fpm"]
