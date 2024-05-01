FROM quay.io/simbelmas/fedora-minimal:v38.33@sha256:5112d879c7c1e23363587b0df4b06fdeda122d78d760e47fd10474adca416ba5 AS Builder

## install build tools and libraries
RUN dnf5 --no-docs  -y install python3-pip python3-devel unzip wget gcc

RUN mkdir /venv /build \
    && python -m venv /venv

ENV PATH=/venv/bin:$PATH

WORKDIR /build
## Grab release
RUN export bazarr_release=$(wget -q https://github.com/morpheus65535/bazarr/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && export download_url="https://github.com/morpheus65535/bazarr/releases/download/${bazarr_release}/bazarr.zip" \
    && echo -n 'Will download from:' ; echo ${download_url} | tee software_downloaded_from \
    && wget -O Bazarr.zip "${download_url}"

###Install  Bazarr
RUN  unzip Bazarr.zip \
     && rm Bazarr.zip \
     && pip install -r requirements.txt

FROM quay.io/simbelmas/fedora-minimal:v38.33@sha256:5112d879c7c1e23363587b0df4b06fdeda122d78d760e47fd10474adca416ba5

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \ 
    && dnf5 --setopt=install_weak_deps=False --quiet --no-docs -y install python unrar ffmpeg \
    && dnf5 clean all

COPY --from=Builder /venv /venv
COPY --from=Builder /build /app
ENV PATH=/venv/bin:$PATH

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd

WORKDIR /opt/mediaData
USER 1001

ENTRYPOINT ["python","/app/bazarr.py"]
CMD ["--no-update", "-c", "/opt/mediaData"]



