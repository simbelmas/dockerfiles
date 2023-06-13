FROM quay.io/simbelmas/fedora-minimal:v37.23@sha256:0d411666af0def8adb5b64e5ea4cfac1c120fe12cc0d2cf11f1b195ce3cf7e13

RUN microdnf --no-docs -y install python3-pip \
    && microdnf clean all

RUN microdnf --no-docs  -y install python3-devel unzip wget gcc \
    && cd /opt \
    && export bazarr_release=$(wget -q https://github.com/morpheus65535/bazarr/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && export download_url="https://github.com/morpheus65535/bazarr/releases/download/${bazarr_release}/bazarr.zip" \
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
    && microdnf -y remove python3-devel unzip wget gcc -x systemd \
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
