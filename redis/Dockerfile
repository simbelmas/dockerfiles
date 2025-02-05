FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:93a8d83b707d0d6a1b9186edecca2e37f83722ae0e398aee4eea0ff17c2fad0e

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

