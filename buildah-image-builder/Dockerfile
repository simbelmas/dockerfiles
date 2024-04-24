
From quay.io/simbelmas/fedora-minimal:v38.32@sha256:ac6269eee7f05f86e43447b968f6369309fada7e8c9ed091840f85db733c1326

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN dnf5 --no-docs -y install shadow-utils buildah skopeo fuse-overlayfs cpp jq --exclude container-selinux,qemu-user-static \
    && rpm --setcaps shadow-utils 2>/dev/null \
    && dnf5 clean all

ENV BUILDAH_ISOLATION=chroot

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
WORKDIR /home/build
ENTRYPOINT ["/bin/sh"]

