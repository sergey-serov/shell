#! /bin/bash

# author: Sergey Serov


# DESCRIPTION
#############
# Configure new workstation system

# TODO: Refactoring is necessary! (January 2024)

# HELP
######


# CONFIG
########

DATA_PATH='/home/sergey/Desktop/evolution-backup/home/sergey'
set -x

# PROGRAM
#########

# cp all other data from backup
###############################
cp -ru $DATA_PATH/backups/* ~/backups
cp -ru $DATA_PATH/home/sergey/Desktop/* ~/Desktop
cp -ru $DATA_PATH/home/sergey/Documents/* ~/Documents
cp -ru $DATA_PATH/home/sergey/Downloads/* ~/Downloads
cp -ru $DATA_PATH/home/sergey/entrepot/* ~/entrepot
cp -ru $DATA_PATH/home/sergey/forge/* ~/forge
cp -ru $DATA_PATH/home/sergey/Music/* ~/Music
cp -ru $DATA_PATH/home/sergey/Pictures/* ~/Pictures
cp -ru $DATA_PATH/home/sergey/programs/* ~/programs
cp -ru $DATA_PATH/home/sergey/Videos/* ~/Videos

cp $DATA_PATH/home/sergey/.selected_editor ~/
cp $DATA_PATH/home/sergey/git-completion.bash ~/
cp $DATA_PATH/home/sergey/git-prompt.sh ~/
cp $DATA_PATH/home/sergey/.bash_history ~/
cp $DATA_PATH/home/sergey/.config/gtk-3.0/bookmarks ~/
cp $DATA_PATH/home/sergey/.bashrc ~/
cp $DATA_PATH/home/sergey/.gitconfig ~/
cp $DATA_PATH/home/sergey/git-completion.bash ~/
cp $DATA_PATH/home/sergey/git-prompt.sh ~/


# System
########
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install pwgen
sudo apt-get install lm-sensors
sudo apt-get install htop
sudo apt-get install iptables-persistent


# Web development
#################

# mysql
sudo apt-get install mysql-server

# apache
sudo apt-get install apache2
echo 'ServerName localhost' | sudo tee --append /etc/apache2/apache2.conf
sudo a2enmod rewrite.load

# php 7
sudo apt-get install php7.0
sudo apt-get install libapache2-mod-php7.0
echo 'date.timezone="Europe/Moscow"' | sudo tee --append /etc/php/7.0/apache2/php.ini
echo 'date.timezone="Europe/Moscow"' | sudo tee --append /etc/php/7.0/cli/php.ini
sudo apt-get install php7.0-gd
sudo apt-get install php7.0-curl
sudo apt-get install php7.0-xml
sudo apt-get install php7.0-mysql
sudo apt-get install php7.0-mbstring
sudo apt-get install
sudo apt-get install

sudo apt-get install php-xdebug

sudo apt-get install jpegoptim
sudo apt-get install optipng

# drupal
########
cd ~
curl https://drupalconsole.com/installer -L -o drupal.phar
sudo mv drupal.phar /usr/local/bin/drupal
sudo chmod +x /usr/local/bin/drupal
drupal init --override

php -r "readfile('http://files.drush.org/drush.phar');" > drush
chmod +x drush
sudo mv drush /usr/local/bin


# Check system
##############

# systemctl status apache2.service
# drupal check
# sudo find / -type f -name 'xdebug.so'
# sudo apt-cache search php7-*
# skype, vcode, chrome
# shortcuts
