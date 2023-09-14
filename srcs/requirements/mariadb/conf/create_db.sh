#!/bin/sh


sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

chown -R root:root /var/lib/mysql /var/run/mysqld
chmod -R 777 /var/lib/mysql /var/run/mysqld


service mariadb start
cat <<E >query.sql
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS $DB_USER@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY '$DB_PASS';
FLUSH PRIVILEGES;
E

mysql -u root --password=root  < query.sql
kill `cat /var/run/mysqld/mysqld.pid`
# rm -rf query
mysqld --skip-log-error