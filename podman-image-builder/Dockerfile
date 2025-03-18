
From quay.io/podman/stable:latest

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs --best -y install skopeo jq \
    && microdnf clean all

USER 1000
WORKDIR /home/podman
ENTRYPOINT ["/bin/sh"]

