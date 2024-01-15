#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Some preparation BEFORE we start update from local workstation


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

# chattr
$ECHO_COMMAND "chattr -R -i $SITE_PATH/www"
chattr -R -i $SITE_PATH/www


# go to maintenance
$ECHO_COMMAND "cp $SITE_PATH/maintenance.html $SITE_PATH/www"
cp $SITE_PATH/maintenance.html $SITE_PATH/www


# clean sessions and tmp
$ECHO_COMMAND "rm -rf $SITE_PATH/sessions/*"
rm -rf $SITE_PATH/sessions/*

$ECHO_COMMAND "rm -rf $SITE_PATH/tmp/*"
rm -rf $SITE_PATH/tmp/*
