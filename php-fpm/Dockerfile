From quay.io/simbelmas/fedora-minimal:v41.44@sha256:aa11a63a3539c1c9ca540c8d38fb54ea1c8777b07147e8a94aa8e90a3de7791b AS Builder

RUN microdnf --nodocs --best -y install git php-devel make gcc-c++ libX11-devel dlib-devel 

RUN git clone https://github.com/goodspb/pdlib.git /build

WORKDIR /build
RUN phpize \
    && ./configure \
    && make


From quay.io/simbelmas/fedora-minimal:v41.44@sha256:aa11a63a3539c1c9ca540c8d38fb54ea1c8777b07147e8a94aa8e90a3de7791b

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs --best -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    && microdnf --nodocs --best -y install  \
        php php-fpm php-opcache \
        php-ctype php-curl php-dom php-gd gd php-iconv php-json \
        php-mbstring php-openssl php-posix php-session \
        php-simplexml php-xmlwriter php-xmlreader php-zip \
        php-common php-pdo_mysql php-fileinfo php-bz2 php-intl \
        php-ftp php-bcmath php-gmp php-exif php-pcntl php-phar \
        php-pecl-redis php-pecl-apcu \
        php-pecl-imagick php-sysvsem \
        php-soap \
        php-sodium \
        ffmpeg perl-Image-ExifTool openh264 x265-libs \
        curl \
        which \
        freetype libpng libjpeg-turbo \
        libxml2 php-xml \
        dlib \
    # Crappy workatound to repopulaire /usr/share/zoneinfo
    && microdnf -y reinstall tzdata \
    && microdnf clean all \
    #Remove defautl php-fpm pool
    && rm /etc/php-fpm.d/www.conf \
    && rm -rf /var/log/php-fpm

COPY --chmod=666 start_fpm /usr/local/bin/
COPY --chmod=666 run_php_command /usr/local/bin/
COPY 00-php-fpm.conf /etc/php-fpm.d/
COPY 00-fpm-www.conf /etc/php-fpm.d/
COPY 000-container-php.ini /etc/php.d/
COPY --from=Builder /build/modules/pdlib.so /usr/lib64/php/modules/pdlib.so

RUN echo -e '[pdlib]\nextension="pdlib.so"' > /etc/php.d/pdlib.ini\
    && chmod 755 /usr/local/bin/start_fpm /usr/local/bin/run_php_command \
    && useradd -d /var/www -s /sbin/nologin -u 1001 app \
    && mkdir -p /var/run/php-fpm /var/www/html \
    && mkdir -p /etc/phpkube/php-conf.d /etc/phpkube/fpm-conf.d \
    && chmod -R a+rwX /var/run/php-fpm /var/www /etc/php.d /etc/php-fpm.d /etc/phpkube /var/lib/php

USER 1001

EXPOSE 9000

CMD ["start_fpm"]
