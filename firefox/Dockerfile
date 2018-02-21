FROM simbelmas/fedora-pulse
RUN dnf -y install firefox \
    && dnf clean all

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENV HOME /home/svc
USER svc

ENTRYPOINT /run.sh
