From quay.io/simbelmas/fedora-minimal:v41.10@sha256:1294bc78ac5ef70e95449562ad7ebe1902b7988c52f309f261659f2d0045b058

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs --best -y install \
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