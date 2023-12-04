FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:2976bc0437deff693af2dcf081a1d1758de8b413e6de861151a5a136c25eb9e4

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

