FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:fa6cafb17588a96358de724c629a1a4ad0e34c7e7362e11c0515c86696940c07

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

