FROM quay.io/simbelmas/fedora-minimal:v41.2@sha256:7b0aa7c0c74aebdbeaeebbf4e8d6bdfe962fc9bc4b97927149ff211191cd11ad

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs -y install imapfilter \
    && microdnf clean all

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /app \
    && chmod -R 700 /app \ 
    && chown -R app:app /app

RUN mkdir -vp /app/creds /app/config \
    && chown -Rv app:app /app \
    && chmod -R 700 /app

COPY --chown=1001:1001 run.lua /app/run.lua

USER 1001

ENTRYPOINT ["imapfilter", "-c", "/app/run.lua"]
CMD []
