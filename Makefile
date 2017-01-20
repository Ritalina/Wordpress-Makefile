DB_USER ?= wordpressuser
DB_PASSWORD ?= password 
DB_NAME ?= wordpress
ROOT_PASSWORD ?= rita

export DEBIAN_FRONTEND="noninteractive"
export DB_USER
export DB_PASSWORD
export DB_NAME
export ROOT_PASSWORD

init:
	apt-get update && apt-get upgrade -y && \
	ufw enable && \
	ufw allow 3306

apache:
	 apt-get install apache2 -y


db_install:
	apt-get install mysql-server-5.7 -y && \
 	echo "mysql-server-5.7  mysql-server/root_password $(ROOT_PASSWORD);" sudo debconf-set-selections && \
	echo "mysql-server-5.7 mysql-server/root_password_again $(ROOT_PASSWORD);" sudo debconf-set-selections
	
php:
	apt-get install php libapache2-mod-php -y && \
	apt-get install php-mcrypt -y && \
	apt-get install php-mysql -y && \
	apt-get install php-cli -y

mod_1:
	sudo rm /etc/apache2/mods-enabled/dir.conf && \
	cp /home/rita/dir.conf /etc/apache2/mods-enabled/ && \
	sudo chmod 1777 /etc/apache2/mods-enabled/dir.conf 

db_create1:
	 mysql -u root -p$(ROOT_PASSWORD) -e "CREATE DATABASE $(DB_NAME);" && "CREATE USER $(DB_USER)@localhost IDENTIFIED by '$(DB_PASSWORD)';" && "GRANT ALL PRIVILEGES ON $(DB_NAME).* TO $(DB_USER)@localhost; && FLUSH PRIVILEGES;" 

tar_wordpress:
	wget http://wordpress.org/latest.tar.gz && \
	tar xzvf latest.tar.gz && \
	apt-get update

conf_wordpress:
	cd ~/wordpress && \
	cp /home/rita/wp-config.php ~/wordpress/ && \
	chmod 1777 ~/wordpress/wp-config.php

cp_raiz:
	cp -r ~/wordpress/* /var/www/html/ && \
	cd /var/www/html && \
	chown -R $(ROOT_PASSWORD):www-data * && \
	mkdir /var/www/html/wp-content/uploads && \
	chown -R $(ROOT_PASSWORD):www-data /var/www/html/wp-content/uploads
