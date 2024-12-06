FROM quay.io/simbelmas/alpine:latest@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45

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
