#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Optimize site style images


# HELP
######

# $1 = full site name
# example: sergey-serov.ru


# CONFIG
########

. /root/1_warehouse/5_script_services/useful_variables.sh

SITE_PATH="$HOME_WWW/$1"

# PROGRAM
#########

$ECHO_COMMAND "Before optimization: "
du -sh $SITE_PATH/www/sites/default/files/styles

$ECHO_COMMAND "Optimize jpeg in $SITE_PATH/www/sites/default/files/styles"
for file in `find $SITE_PATH/www/sites/default/files/styles -type f -name '*.jpg'`; do
  optimize_jpeg "$file";
done

$ECHO_COMMAND "Optimize png in $SITE_PATH/www/sites/default/files/styles"
for file in `find $SITE_PATH/www/sites/default/files/styles -type f -name '*.png'`; do
  optimize_png "$file";
done

$ECHO_COMMAND "After optimization: "
du -sh $SITE_PATH/www/sites/default/files/styles
