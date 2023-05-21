FROM ghcr.io/kengo-k/dev-base-nodejs:202305212306-de55a20

LABEL org.opencontainers.image.description="Account-Backendの開発用イメージ"

USER root

RUN apt-get update \
  && apt-get -y install postgresql-client

USER container-user
