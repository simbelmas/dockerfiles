FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:68edcadfac2eba9ae95651ef4f736b9a3871afb57f7275c6ca243793bff5a55d

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

