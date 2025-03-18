FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:5250fed70d8a66f4901a8beace6f85bee9550c0fc6fd42d10e2c1cd24cf93a0d

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

