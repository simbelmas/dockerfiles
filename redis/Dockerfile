FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:ea30bef6a1424d032295b90db20a869fc8db76331091543b7a80175cede7d887

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

