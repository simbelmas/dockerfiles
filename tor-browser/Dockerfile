ARG baseimg=registry.fedoraproject.org/fedora:latest
FROM $baseimg
LABEL maintainer "Simon Belmas <slos@soket.fr>"
ENV LANG C.UTF-8

WORKDIR /tmp

RUN set -x \
    && latest_tor=$(curl  -sS -o - --connect-timeout 3 https://www.torproject.org/download/ | awk -F \" '$0 ~ /btn.*downloadLink.*tor-browser-linux/ { print $4 }') \
    && if [ -z "${latest_tor}" ] ; then echo "cannot find latest tor version, exiting" >&2 ; exit 1 ; fi \
    && dnf install -y xz zenity file dbus-glib libX11-xcb libXt \
    && curl -sSOL https://www.torproject.org/${latest_tor} \
    && curl -sSOL https://www.torproject.org/${latest_tor}.asc \
    && export GNUPGHOME=$(mktemp -d) \
    && gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org \
    && gpg2 --verify $(basename "${latest_tor}"){.asc,} \
    && tar -C /usr/local/bin -Jxv --strip-components 1 -f $(basename "${latest_tor}") \
    && dnf clean all \
    && chmod a+x /usr/local/bin/Browser/start-tor-browser \
    && chmod a+rX -R /usr/local/bin/Browser \
    && sed '/"`id -u`" -eq 0/,/fi/{d}' -i /usr/local/bin/Browser/start-tor-browser \
    && rm -rf ${GNUPGHOME} /tmp/$(basename "${latest_tor}")* /var/cache/dnf

ENTRYPOINT ["/usr/local/bin/Browser/start-tor-browser", "--log", "/dev/stdout"]

