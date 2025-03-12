FROM quay.io/simbelmas/fedora-minimal:v41.34@sha256:43abe31e2690db93f6b66b26715a8cd97e5511d478662c9fe5ff8356d687fae0

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
