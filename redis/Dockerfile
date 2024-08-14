FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:e30eac723e308f27e92cb609024b6be3ed2b2fb67899ec37043f743b169e17a5

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

