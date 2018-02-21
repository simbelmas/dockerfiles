FROM simbelmas/fedora-pulse
RUN dnf -y install dbus-x11 \
    && dnf clean all

ENV HOME /home/svc

ENTRYPOINT /bin/bash
