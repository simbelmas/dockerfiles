From quay.io/simbelmas/fedora-minimal:v41.2@sha256:7b0aa7c0c74aebdbeaeebbf4e8d6bdfe962fc9bc4b97927149ff211191cd11ad

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs -y install \
    hugo git zsh tzdata \
    && microdnf clean all

RUN mkdir -p /app/.ssh /app/hugosource
COPY ./entrypoint.sh /app/entrypoint.sh

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /app \
    && chmod -R 700 /app \ 
    && chown -R app:app /app

RUN chmod 755 /app/entrypoint.sh \
    && mkdir -p /var/www/html \
    && chown -R 1001:1001 /var/www/ \
    && chmod -R 755 /var/www/

USER 1001
WORKDIR /var/www/hugo

ENTRYPOINT ["/app/entrypoint.sh"]