FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:e59c42a34bdb950f988a1578504c31ce981096e3a18b83db1808bd7a32302e7f

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

