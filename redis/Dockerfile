FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:ca65ea36ae16e709b0f1c7534bc7e5b5ac2e5bb3c97236e4fec00e3625eb678d

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

