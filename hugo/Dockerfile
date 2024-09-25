From quay.io/simbelmas/fedora-minimal:v40.5@sha256:5d07cd8f2a0b530d74c3cb24e553ac5147f040d657fb3361075a5869d68e71a3

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN dnf5 install --setopt=install_weak_deps=False --no-docs -y install \
    hugo git zsh tzdata \
    && dnf5 clean all

RUN mkdir -p /app/.ssh /app/hugosource
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod 755 /app/entrypoint.sh \
    && useradd -d /app -s /sbin/nologin -u 1001 app \
    && chown -R 1001:1001 /app \
    && chmod -R 700 /app \
    && mkdir -p /var/www/html \
    && chown -R 1001:1001 /var/www/ \
    && chmod -R 755 /var/www/

USER 1001
WORKDIR /var/www/hugo

ENTRYPOINT ["/app/entrypoint.sh"]