FROM simbelmas/fedora-dbus
RUN dnf -y install filezilla \
    && dnf clean all

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENV HOME /home/svc
USER svc

ENTRYPOINT /run.sh
