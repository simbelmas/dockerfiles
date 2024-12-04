FROM quay.io/simbelmas/fedora-minimal:v41.8@sha256:e4d0f456c200168a78a40bc41078154452979e2cec9efa7b2096d78e8394647b AS Builder

## install build tools and libraries
RUN microdnf --nodocs --best -y install python3-pip python3-devel unzip wget gcc

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

FROM quay.io/simbelmas/fedora-minimal:v41.8@sha256:e4d0f456c200168a78a40bc41078154452979e2cec9efa7b2096d78e8394647b

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs --best -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \ 
    && microdnf --nodocs --best -y install python unrar ffmpeg \
    && microdnf clean all

COPY --from=Builder /venv /venv
COPY --from=Builder /build /app
ENV PATH=/venv/bin:$PATH

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd

WORKDIR /opt/mediaData
USER 1001

ENTRYPOINT ["python","/app/bazarr.py"]
CMD ["--no-update", "-c", "/opt/mediaData"]



