FROM --platform=amd64 mariadb:10
LABEL MAINTAINER="jeongmin1237@gmail.com"
ENV MARIADB_DATABASE=store
ENV MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true
ENV MARIADB_USER=root
ADD init.sql /docer-entrypoint-initdb.d
EXPOSE 3306