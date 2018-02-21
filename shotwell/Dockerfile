FROM simbelmas/fedora-dbus
RUN dnf -y install shotwell \
    && dnf clean all

COPY run.sh /run.sh
RUN chown -R svc: /home/svc  \
    && chmod a+x /run.sh

ENV HOME /home/svc

ENTRYPOINT /run.sh
