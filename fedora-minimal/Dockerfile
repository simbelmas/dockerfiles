FROM registry.fedoraproject.org/fedora-minimal:37

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf upgrade -y --nodocs --setopt install_weak_deps=0 \
    && microdnf clean all

