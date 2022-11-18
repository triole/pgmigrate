FROM postgres:latest

ENV VOL=/vol
ENV POSTGRES_HOST_AUTH_METHOD=trust
ENV LANG=en_US.UTF-8

ARG UID
ARG GID

RUN apt update && apt upgrade -y && apt install -y \
        postgresql-client curl micro procps \
 && rm -rf /var/lib/apt/lists/*

COPY ./sh/* /usr/bin/

RUN curl --output /root/.bashrc \
    https://raw.githubusercontent.com/triole/ghwfe/master/bashrc/default.sh

RUN sed -i -r "s/postgres:x:([0-9]+):([0-9]+)/postgres:x:${UID}:${GID}/g" /etc/passwd
RUN sed -i -r "s/postgres:x:([0-9]+)/postgres:x:${GID}/g" /etc/group
