#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Some preparation AFTER we update site from local workstation


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

# correct files owner, permissions, selinux context
$ECHO_COMMAND "$HOME_SHELL_SCRIPTS/3_update_site/correct-file-attributes.sh $SITE_NAME"
$HOME_SHELL_SCRIPTS/3_update_site/correct-file-attributes.sh $SITE_NAME


# clean files
$ECHO_COMMAND "$HOME_SHELL_SCRIPTS/3_update_site/clean.sh $SITE_NAME"
$HOME_SHELL_SCRIPTS/3_update_site/clean.sh $SITE_NAME


# Return to online from maintenence
$ECHO_COMMAND "rm -f $SITE_PATH/www/maintenance.html"
rm -f $SITE_PATH/www/maintenance.html


# Final protect all files except sites/default/files
$ECHO_COMMAND "$HOME_SHELL_SCRIPTS/3_update_site/protect-from-changes.sh"
$HOME_SHELL_SCRIPTS/3_update_site/protect-from-changes.sh $SITE_NAME
