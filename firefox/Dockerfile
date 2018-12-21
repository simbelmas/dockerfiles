FROM simbelmas/fedora-pulse
RUN dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    dnf -y install firefox && \
    dnf install -y gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 && \
    dnf clean all

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENV HOME /home/svc

ENTRYPOINT /run.sh
