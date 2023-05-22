FROM ghcr.io/kengo-k/dev-base-nodejs:202305222323-c664e22

LABEL org.opencontainers.image.description="Account-Backend開発用イメージ"

USER root

RUN apt-get update \
  && apt-get -y install postgresql-client

USER container-user
