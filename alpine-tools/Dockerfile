FROM quay.io/simbelmas/alpine:latest@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add \
       nfs-utils \
       git less openssh curl \
       rsync \
       python3 py3-pip py3-setuptools py3-wheel \
       openssl libacl libattr \
       borgbackup \
       zsh \
       py3-kubernetes \
       jinja2-cli py3-jinja2

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -u 1001 -s /bin/nologin svc \
    && adduser -G www-data -D -u 82 -s /sbin/nologin www-data

USER 1001

CMD ["git", "--help"]
