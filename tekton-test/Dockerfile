FROM quay.io/simbelmas/fedora-minimal:v38.26@sha256:828891d431b7f85a386d0ffa896c2344996114ec342f818247ca9ce88a05016a

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
