FROM quay.io/simbelmas/alpine:latest@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add \
       nfs-utils \
       git less openssh curl \
       rsync \
       python3 py3-pip \
       openssl libacl libattr \
       borgbackup \
    && apk --no-cache  add -t dev_tools openssl-dev make gcc libc-dev pkgconf python3-dev acl-dev attr-dev linux-headers \
    && pip3 install --upgrade pip setuptools wheel \
    && pip3 install kubernetes jinja2-tools \
    && pip3 install pkgconfig \
    && pip3 uninstall -y pkgconfig \
    && apk del dev_tools
#    && pip3 install borgbackup \

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -u 1001 -s /bin/nologin svc \
    && adduser -G www-data -D -u 82 -s /sbin/nologin www-data

USER 1001

CMD ["git", "--help"]
