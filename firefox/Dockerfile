FROM  fedora
RUN dnf -y install dbus-x11 firefox \
    && dnf clean all \
    && rm -rf /var/cache/dnf

ENTRYPOINT ["/usr/bin/firefox"]
CMD ["--new-instance"]
