FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:b5e0821350e8d5880450c0264f29ac0395fab3f46204fe43a1f6a8da8c1f8572

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

