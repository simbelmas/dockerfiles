FROM registry.fedoraproject.org/fedora-minimal:40

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN echo -e "fastestmirror=True\nmax_parallel_downloads=10" >> /etc/dnf/dnf.conf \
    && dnf5 --no-docs -y upgrade \
    && dnf5 clean all


