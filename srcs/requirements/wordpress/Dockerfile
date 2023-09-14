FROM debian:bullseye

# Set arguments and environment variables
# ENV DB_NAME="wordpress" \
#     DB_USER="wpuser" \
#     DB_PASS="wppass"

# Update and install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y php php-mysqli php-fpm wget unzip curl vim && \
    rm -rf /var/lib/apt/lists/*

# Create the /var/www directory
RUN mkdir -p /var/www /run/php/

COPY ./requirements/wordpress/conf/wp-config-create.sh ./tmp

# Download and extract WordPress to a temporary directory
RUN apt-get update && apt-get install -y php-cli php-phar mariadb-server && \
    chmod +x ./tmp/wp-config-create.sh

# Modify PHP-FPM configuration
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf


CMD ["bash", "./tmp/wp-config-create.sh"]