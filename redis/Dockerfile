FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:7ec631665e5daf2179f70893b742e7eed2e9ce256da2e5fa1088abf8f97754a1

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

