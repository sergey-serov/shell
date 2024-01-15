#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Update drupal core


# HELP
######

# $1 = full site name
# example: sergey-serov.ru

# $2 = drupal minor version
# example: 38


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh

SITE_NAME=$1
SITE_PATH="$HOME_WWW/$SITE_NAME"

MINOR_VERSION=$2


# PROGRAM
#########

wget http://ftp.drupal.org/files/projects/drupal-7.$MINOR_VERSION.tar.gz
