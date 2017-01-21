#!/bin/bash

#Instalacion
echo "mysql-server-5.7 mysql-server/root_password password rita" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password rita" | sudo debconf-set-selections
sudo apt-get install mysql-server-5.7 -y

#Crear base de datos
mysql -u root -prita -e "CREATE DATABASE 'wordpress'; CREATE USER 'wordpressuser@localhost' IDENTIFIED BY 'password'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost; FLUSH PRIVILEGES;"
