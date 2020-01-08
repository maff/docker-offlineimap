FROM debian:buster-slim

ENV UID 9000
ENV GID 9000

VOLUME /target

RUN useradd \
    --shell /bin/bash \
    --uid 9000 \
    --create-home \
    --user-group \
    --comment "Unprivileged user" docker

WORKDIR /home/docker

RUN apt-get update \
    && apt-get install -y --no-install-recommends gosu offlineimap \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
