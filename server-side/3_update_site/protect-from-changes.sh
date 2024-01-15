#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Protect site documents from changes by attribute 'i'


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

# chattr
run_command "chattr -R +i $SITE_PATH/www"

run_command "chattr -R -i $SITE_PATH/www/sites/default/files"

run_command "chattr +i $SITE_PATH/www/sites/default/files/.htaccess"
