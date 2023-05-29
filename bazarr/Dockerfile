FROM quay.io/simbelmas/fedora-minimal:v37.20@sha256:0afae7c6437395a805428f6d28d59089b41d5162decbc04f3c921b3b93f7cc7c

RUN microdnf -y install python3-pip \
    && microdnf clean all

RUN microdnf -y install python3-devel microdnf unzip wget gcc \
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
