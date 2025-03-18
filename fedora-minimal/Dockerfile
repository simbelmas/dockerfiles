FROM registry.fedoraproject.org/fedora-minimal:41

LABEL maintainer "Simon Belmas <slos@soket.fr>"

#RUN echo -e "fastestmirror=True\nmax_parallel_downloads=10" >> /etc/dnf/dnf.conf \
RUN microdnf --nodocs --best -y upgrade \
    && microdnf clean all


