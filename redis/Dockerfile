FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:7f26b254f1169010a2c0e160d166f0e12fb05ceab21a1efc342e43ad397a2674

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

