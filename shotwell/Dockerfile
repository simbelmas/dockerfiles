FROM simbelmas/fedora-dbus
RUN dnf -y install shotwell \
    && dnf -y install pulseaudio \
    && dnf -y install dbus-x11 \
    && dnf clean all

RUN useradd svc \
    && usermod -a -G audio,video,disk svc

COPY run.sh /run.sh
COPY pulse-client.conf /home/svc/.config/pulse/client.conf
RUN chown -R svc: /home/svc  \
    && chmod a+x /run.sh

ENV HOME /home/svc

ENTRYPOINT /run.sh
