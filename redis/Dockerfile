FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:d6ecc832969a4827645a083da38345327b3447772fe907e7d4311c79b4e3a06e

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

