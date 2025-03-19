FROM quay.io/simbelmas/fedora-minimal:v41.38@sha256:95629013a62814850a48dfc9656687eeb257484c51616dce02138b1cb57dd406

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
