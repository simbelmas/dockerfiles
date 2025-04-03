FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:bd41d55aae1ecff61b2fafd0d66761223fe94a60373eb6bb781cfbb570a84079

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]

