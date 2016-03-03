# DOCKER-VERSION 1.9.1
FROM alpine:3.3
MAINTAINER kballou@devnulllabs.io

ENV LANG="en_US.UTF-8"
ENV ELIXIR_VER=1.2.3
ENV ELIXIR_URL=https://github.com/elixir-lang/elixir/releases/download/v$ELIXIR_VER/Precompiled.zip
ENV MIX_ENV=prod

WORKDIR /opt/

VOLUME ["/opt/apps"]

RUN apk update && apk add \
    bash \
    curl \
    ncurses-terminfo-base \
    ncurses-terminfo \
    ncurses-libs \
    libedit \
    libpq \
    postgresql-client \
    erlang-asn1 \
    erlang-crypto \
    erlang-hipe \
    erlang-mnesia \
    erlang-runtime-tools \
    erlang-sasl \
    erlang-ssl \
    erlang-stdlib \
    erlang-tools \
    erlang

RUN set -x \
    && curl -fSL "$ELIXIR_URL" -o /tmp/elixir.zip \
    && mkdir /opt/elixir \
    && unzip /tmp/elixir.zip -d /opt/elixir \
    && rm -f /tmp/elixir.zip