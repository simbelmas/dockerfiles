
From quay.io/simbelmas/fedora-minimal:v41.35@sha256:de452fd3d9316b7d14619062b0e6f9e73988bd528022490e924b4b05433dbc5a

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs --best -y install podman shadow-utils skopeo fuse-overlayfs ucpp jq --exclude container-selinux \
    && rpm --setcaps shadow-utils 2>/dev/null \
    && microdnf clean all

RUN sed -e 's|^#mount_program|mount_program|g' -e '/additionalimage.*/a "/var/lib/shared",' -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g' /usr/share/containers/storage.conf > /etc/containers/storage.conf \
    && chmod 644 /etc/containers/storage.conf \
    && mkdir -p /var/lib/shared/overlay-images /var/lib/shared/overlay-layers /var/lib/shared/vfs-images /var/lib/shared/vfs-layers \
    && touch /var/lib/shared/overlay-images/images.lock \
    && touch /var/lib/shared/overlay-layers/layers.lock \
    && touch /var/lib/shared/vfs-images/images.lock \
    && touch /var/lib/shared/vfs-layers/layers.lock \
    && useradd -u 1001 build \
    && echo -e "build:1:1000\nbuild:1002:64535" > /etc/subuid  \
    && cp /etc/subuid /etc/subgid \
    && mkdir -p /home/build/.local/share/containers \
    && chown -R build:build /home/build


USER 1001

ENV _CONTAINERS_USERNS_CONFIGURED="" \
    BUILDAH_ISOLATION=chroot

WORKDIR /home/build
ENTRYPOINT ["/bin/sh"]

