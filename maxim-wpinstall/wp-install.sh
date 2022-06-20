#!/bin/bash

echo "Thank you for using this Wordpress install script by KhaosTheMaxim"
sleep 1
echo "Updating packages"
sudo apt update
sudo apt upgrade -y
echo "Down updating packages"\

echo "Installing required packages"
sudo apt install apache2 -y
sudo apt install ghostscript -y
sudo apt install libapache2-mod-php -y
sudo apt install mysql-server -y
sudo apt install php -y
sudo apt install php-bcmath -y
sudo apt install php-curl -y
sudo apt install php-imagick -y
sudo apt install php-intl -y
sudo apt install php-json -y
sudo apt install php-mbstring -y
sudo apt install php-mysql -y
sudo apt install php-xml -y
sudo apt install php-zip -y
sleep 3
echo "Done installing required packages"

echo "Installing Wordpress"
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
echo "Done Installing Wordpress"

echo "Configuring wordpress with apache2"
sudo cp wp.conf /etc/apache2/sites-available/wordpress.conf
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload
echo "Done Configuring Wordpress with apache2"

echo "Configuring database with Wordpress"
mysql -u root << EOF
CREATE DATABASE wordpress;
CREATE USER wordpress@localhost IDENTIFIED BY 'wordpress';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
ON wordpress.*
TO wordpress@localhost;
FLUSH PRIVILEGES;
EOF
sudo service mysql start
echo "Done configuring database for Wordpress"

echo "Connecting database to Wordpress"
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/wordpress/' /srv/www/wordpress/wp-config.php
echo "Done Connecting database to wordpress"

sudo ufw allow 80

echo "Go to your Ip Address or Domain Configured with your server"

echo "Please note that there is an extra step to do yourselfZ"
echo "Go to "
echo "https://api.wordpress.org/secret-key/1.1/salt/"
echo "copy that and edit the file wp-config"
sleep 5 
echo "Do this by entering sudo nano /srv/www/wordpress/wp-config.php [Make sure you have nano installed]"
echo "Replace the similar looking text with the on you got with the api"
echo "Now Your Wordpress install is complete"
echo "Thank You for using my script"


