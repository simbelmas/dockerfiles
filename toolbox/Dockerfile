FROM quay.io/simbelmas/fedora-minimal:v41.10@sha256:1294bc78ac5ef70e95449562ad7ebe1902b7988c52f309f261659f2d0045b058

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /app \
    && chmod -R 700 /app \ 
    && chown -R app:app /app

RUN echo 'www-data:x:82:' >> /etc/group \
    && echo 'www-data:x:82:82::/www-data:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /www-data \
    && chmod -R 700 /www-data \ 
    && chown -R www-data:www-data /www-data

RUN  microdnf --nodocs --best -y install \
       nfs-utils \
       git less openssh curl \
       rsync \
       python3 python3-pip python3-setuptools python3-wheel \
       openssl libacl libattr \
       borgbackup \
       zsh \
       time \
       netcat \
       python3-kubernetes \
       python3-jinja2-cli python3-jinja2 \
        && microdnf clean all

USER 1001

