FROM quay.io/simbelmas/fedora-minimal:v41.19@sha256:4b29fa1b47264d266890d71d5dbeded96eb287ec42bd6376f8d923146fa51fdf

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs --best -y install imapfilter \
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
