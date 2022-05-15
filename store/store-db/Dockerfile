FROM --platform=amd64 mysql
ENV MYSQL_DATABASE=store
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true
ADD init.sql /docker-entrypoint-initdb.d
EXPOSE 3306