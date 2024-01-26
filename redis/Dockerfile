FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:b5ddcd52d425a8e354696c022f392fe45fca928f68d6289e6bb4a709c3a74668

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

