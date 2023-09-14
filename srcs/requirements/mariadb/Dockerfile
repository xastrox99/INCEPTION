FROM debian:bullseye

RUN apt-get -y update

# ENV DB_USER="wpuser" \
#     DB_PASS="wppass"

RUN apt-get -y upgrade && apt-get install -y mariadb-server mariadb-client

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

RUN mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql \
    && chmod 777 /var/lib/mysql


COPY ./requirements/mariadb/conf/create_db.sh .

RUN chmod +x ./create_db.sh

CMD [ "./create_db.sh" ]