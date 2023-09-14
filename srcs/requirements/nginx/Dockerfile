FROM debian:bullseye

RUN  apt-get update && apt-get -y upgrade && apt-get install -y nginx curl openssl &&\
    cp /var/www/html/index.nginx-debian.html /var/www/index.html; 

EXPOSE 443

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/mbaazzy.42.fr.key -out /etc/ssl/certs/mbaazzy.42.fr.crt -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"

COPY ./conf/nginx.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]