ROOT_PASSWORD ?= rita

export ROOT_PASSWORD

init:
	apt-get update && apt-get upgrade -y && \
	ufw enable && \
	ufw allow 3306

apache:
	 apt-get install apache2 -y
mysql:
        sh mysql.sh
php:
	apt-get install php libapache2-mod-php -y && \
	apt-get install php-mcrypt -y && \
	apt-get install php-mysql -y && \
	apt-get install php-cli -y

mod_1:
	sudo rm /etc/apache2/mods-enabled/dir.conf && \
	cp /home/rita/dir.conf /etc/apache2/mods-enabled/ && \
	sudo chmod 1777 /etc/apache2/mods-enabled/dir.conf 


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
