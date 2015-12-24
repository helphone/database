FROM kiasaki/alpine-postgres:latest
MAINTAINER Gaël Gillard <gael@gaelgillard.com>

ENV POSTRES_USER postgres
ENV POSTGRES_PASSWORD postgres

ADD ./sql /docker-entrypoint-initdb.d/
