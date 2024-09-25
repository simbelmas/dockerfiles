FROM quay.io/simbelmas/fedora-minimal:v40.5@sha256:5d07cd8f2a0b530d74c3cb24e553ac5147f040d657fb3361075a5869d68e71a3

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
