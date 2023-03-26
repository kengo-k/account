FROM ghcr.io/kengo-k/dev-base-nodejs:202303201044-3c6e0ee

LABEL org.opencontainers.image.description="Accountプロジェクト用の作業用イメージ"

RUN apt-get update && \
  apt-get install -y python3 &&  \
    && apt-get -y install postgresql-client && \
    && apt-get -y install ruby-activerecord && \
    && apt-get -y install ruby-pg
