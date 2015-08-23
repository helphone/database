FROM postgres:latest
MAINTAINER Gaël Gillard <gael@gaelgillard.com>

ENV POSTRES_USER postgres

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ADD ./sql /docker-entrypoint-initdb.d/