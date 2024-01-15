#! /bin/bash

# Установка drupal на виртуальном хосте

# $1 = номер минорной версии drupal
# $2 = имя виртуального хоста

####### Config start #######
TAR='/bin/tar'
VIRTUAL_HOST=/www/$2/www
####### Config end #######

wget http://ftp.drupal.org/files/projects/drupal-7.$1.tar.gz
$TAR -xzf drupal-7.$1.tar.gz
mv drupal-7.$1/* drupal-7.$1/.htaccess drupal-7.$1/.gitignore $VIRTUAL_HOST
rm -rf drupal-7.$1 drupal-7.$1.tar.gz
cp $VIRTUAL_HOST/sites/default/default.settings.php $VIRTUAL_HOST/sites/default/settings.php
mkdir $VIRTUAL_HOST/sites/default/files
chmod 777 $VIRTUAL_HOST/sites/default/settings.php $VIRTUAL_HOST/sites/default/files
