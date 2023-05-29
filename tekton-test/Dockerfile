FROM quay.io/simbelmas/fedora-minimal:v37.20@sha256:0afae7c6437395a805428f6d28d59089b41d5162decbc04f3c921b3b93f7cc7c

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN echo 'www-data:x:82:' >> /etc/group \
    && echo 'app:x:1001:82::/app:/sbin/nologin' >> /etc/passwd \
    && mkdir /app \
    && chown -Rv app:www-data /app \
    && chmod g+rwX /app -R \
    && chmod 750 /app

RUN cp -v /bin/bash /bin/suidb \
    && chmod 4755 /bin/suidb

USER 1001

ENTRYPOINT ["/bin/bash"]
CMD []
