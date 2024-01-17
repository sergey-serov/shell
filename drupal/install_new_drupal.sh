#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Install new Drupal 7. Good for development.
# Virtual host must be prepared before.
# Database must be prepared before.
# Database name, user and password is equal as
# virtual host short name, without suffix .local


# HELP
######

# $1 = virtual host short name, without suffix .local
# Example: forge1


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

VIRTUAL_HOST_SHORT_NAME=$1
VIRTUAL_HOST_FULL_NAME="$VIRTUAL_HOST_SHORT_NAME.local"


# PROGRAM
#########

$HOME_SCRIPT_SERVICES/work-start.sh "Installing new drupal to virtual host '$VIRTUAL_HOST_SHORT_NAME'"

cd $HOME_WWW/$VIRTUAL_HOST_FULL_NAME/www
rm -rf ./* .gitignore .htaccess

drush dl drupal --drupal-project-rename=new_drupal

mv -f new_drupal/* new_drupal/.htaccess new_drupal/.gitignore .
rm -rf new_drupal/

drush site-install standard --db-url=mysql://$VIRTUAL_HOST_SHORT_NAME:$VIRTUAL_HOST_SHORT_NAME@localhost/$VIRTUAL_HOST_SHORT_NAME --site-name=$VIRTUAL_HOST_SHORT_NAME --account-name=$VIRTUAL_HOST_SHORT_NAME --account-pass=$VIRTUAL_HOST_SHORT_NAME

sudo $HOME_SHELL_SCRIPTS/drupal/chmod_and_chown_for_host.sh $VIRTUAL_HOST_SHORT_NAME

$HOME_SCRIPT_SERVICES/work-end-summary.sh  "Installing new drupal to virtual host '$VIRTUAL_HOST_SHORT_NAME'"
$HOME_SCRIPT_SERVICES/work-end-sound.sh
