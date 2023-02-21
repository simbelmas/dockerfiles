FROM quay.io/simbelmas/fedora-minimal:v37.11@sha256:6ae37cccca327d5c9529c8824b0d81a8e141aed331874827f116f10ca09e9938

RUN microdnf -y install python3-pip \
    && microdnf clean all

RUN microdnf -y install python3-devel microdnf unzip wget gcc \
    && cd /opt \
    && export download_url="https://github.com/morpheus65535/bazarr/releases/download/v1.1.1/bazarr.zip" \
    && echo ${download_url} > software_downloaded_from \
    && wget -O Bazarr.zip "${download_url}" \
    && wget -O rpmfusion-free.rpm https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    && wget -O rpmfusion-nonfree.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    && rpm -i *.rpm \
    && rm *.rpm \
    && mkdir Bazarr \
    && cd Bazarr \
    && unzip ../Bazarr.zip \
    && rm ../Bazarr.zip \
    && pip install -r requirements.txt \
    && microdnf -y remove python3-devel unzip wget gcc \
    && microdnf clean all

RUN microdnf -y install unrar ffmpeg \
    && microdnf clean all

RUN useradd -U -m -d /opt/mediaData -u 1001 -s /bin/nologin media \
    && chown -Rv media: /opt/Bazarr

USER 1001
WORKDIR /opt/mediaData
ENTRYPOINT ["python3","/opt/Bazarr/bazarr.py"]
CMD ["--no-update", "-c", "/opt/mediaData"]


LABEL maintainer "Simon Belmas <slos@soket.fr"
