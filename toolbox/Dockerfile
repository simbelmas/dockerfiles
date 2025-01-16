FROM quay.io/simbelmas/fedora-minimal:v41.19@sha256:4b29fa1b47264d266890d71d5dbeded96eb287ec42bd6376f8d923146fa51fdf

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

