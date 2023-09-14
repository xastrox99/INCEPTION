#!/bin/bash

# Download WP-CLI and make it executable
while [[ ! $(mysqladmin ping -h $DB_HOST -u $DB_USER --password=$DB_PASS) ]]
do
    sleep 1
done
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# Move WP-CLI to a location in your PATH (e.g., /usr/local/bin/) to make it globally accessible
mv wp-cli.phar /opt/wp-cli.phar

cd /opt

# Verify WP-CLI installation
/opt/wp-cli.phar --allow-root --version 

# WordPress installation directory
INSTALL_DIR="/var/www/"

# Step 1: Download WordPress using WP-CLI
/opt/wp-cli.phar --allow-root core download --path="$INSTALL_DIR"
# chmod -R 0777 /var/www/wp-content 

# Step 2: Create a wp-config.php file
/opt/wp-cli.phar --allow-root config create --path="$INSTALL_DIR" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOST"

# Step 3: Install WordPress
/opt/wp-cli.phar --allow-root core install --path="$INSTALL_DIR" --url="http://localhost" --title="$WP_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASS" --admin_email="$WP_EMAIL"


# CREATE USER
/opt/wp-cli.phar --allow-root --path="$INSTALL_DIR" user create $WP_USER_2 $WP_EMAIL_2 --user_pass="$WP_PASS_2" --role=editor


/usr/sbin/php-fpm7.4 -F
