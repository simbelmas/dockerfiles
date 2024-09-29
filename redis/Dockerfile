FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:6725a7dc7a44a6486b9d0a5172b10ccaf0c2ea600df87c0b93450d0e7769297f

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

