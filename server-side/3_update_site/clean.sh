#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Clean files from dangerous and not necessary on the site


# HELP
######

# $1 = full site name
# example: sergey-serov.ru


# CONFIG
########

. /root/1_warehouse/5_script_services/useful_variables.sh

SITE_NAME=$1
SITE_PATH="$HOME_WWW/$SITE_NAME"


# PROGRAM
#########

# remove common txt
$ECHO_COMMAND "find $SITE_PATH/www \( -name "CHANGELOG.txt" -o -name "LICENSE.txt" -o -name "README.txt" -o -name "COPYRIGHT.txt" \) -type f -exec rm {} \;"
find $SITE_PATH/www \( -name "CHANGELOG.txt" -o -name "LICENSE.txt" -o -name "README.txt" -o -name "COPYRIGHT.txt" \) -type f -exec rm {} \;
