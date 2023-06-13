FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:6a5130174e14177c3777ea34f4989a91bb5a7d7562dd48578cbfa3ad8cd53743

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

