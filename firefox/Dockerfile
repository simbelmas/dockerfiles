FROM  fedora
LABEL maintainer "Simon Belmas <slos@soket.fr>"
RUN dnf -y install dbus-x11 firefox \
    && dnf clean all \
    && rm -rf /var/cache/dnf

ENTRYPOINT ["/usr/bin/firefox"]
CMD ["--new-instance"]
