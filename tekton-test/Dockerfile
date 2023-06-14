FROM quay.io/simbelmas/fedora-minimal:v38.1@sha256:04239c043250c1e113497fc85fda407e5965e9772194e765295240975f52fe88

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
