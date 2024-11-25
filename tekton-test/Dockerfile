FROM quay.io/simbelmas/fedora-minimal:v41.2@sha256:7b0aa7c0c74aebdbeaeebbf4e8d6bdfe962fc9bc4b97927149ff211191cd11ad

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
