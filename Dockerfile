# DOCKER-VERSION 1.9.1
FROM alpine:3.3
MAINTAINER kballou@devnulllabs.io

ENV LANG="en_US.UTF-8"
ENV ELIXIR_VER=1.2.4
ENV ELIXIR_URL=https://github.com/elixir-lang/elixir/releases/download/v$ELIXIR_VER/Precompiled.zip
ENV MIX_ENV=prod
ENV PATH /opt/elixir/bin:$PATH

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
    erlang-dev \
    erlang-hipe \
    erlang-inets \
    erlang-kernel \
    erlang-mnesia \
    erlang-public-key \
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

RUN set -x \
    && mix local.hex --force \
    && mix hex.info \
    && mix local.rebar
