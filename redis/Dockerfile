FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:bf2eef6365155332a8a9f86255818c8cef43f1ebb70ed0335712d596662c1510

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

