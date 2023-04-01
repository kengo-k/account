FROM ghcr.io/kengo-k/dev-base-nodejs:202304012334-aa29e8c

LABEL org.opencontainers.image.description="Accountプロジェクト用の作業用イメージ"

USER root

RUN apt-get update \
  && apt-get install -y python3 \
  && apt-get -y install postgresql-client \
  && apt-get -y install ruby-activerecord \
  && apt-get -y install ruby-pg \
  && ln -s /usr/bin/python3 /usr/bin/python

USER container-user
