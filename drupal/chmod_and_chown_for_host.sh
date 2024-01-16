#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# "Right" permissions and owner for drupal 7 site files
# Good use after update from remote server
# Need run with sudo!


# HELP
######

# $1 = virtual host short name, without suffix .local
# Example: forge1


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

VIRTUAL_HOST_SHORT_NAME=$1
VIRTUAL_HOST_ROOT="$HOME_WWW/$VIRTUAL_HOST_SHORT_NAME.local"


# PROGRAM
#########

# $HOME_SCRIPT_SERVICES/work-start.sh

sudo chown -R sergey:sergey $VIRTUAL_HOST_ROOT
sudo chown -R www-data:www-data $VIRTUAL_HOST_ROOT/logs
sudo chown -R www-data:www-data $VIRTUAL_HOST_ROOT/tmp
sudo chown -R www-data:www-data $VIRTUAL_HOST_ROOT/sessions
sudo chown -R www-data:www-data $VIRTUAL_HOST_ROOT/www/sites/default/files


sudo find $VIRTUAL_HOST_ROOT -type f -exec chmod 644 {} \;
sudo find $VIRTUAL_HOST_ROOT -type d -exec chmod 755 {} \;

sudo chmod 777 $VIRTUAL_HOST_ROOT/logs
sudo chmod 777 $VIRTUAL_HOST_ROOT/tmp
sudo chmod 777 $VIRTUAL_HOST_ROOT/sessions
sudo chmod 777 $VIRTUAL_HOST_ROOT/www/sites/default/files

# $HOME_SCRIPT_SERVICES/work-end-summary.sh
# $HOME_SCRIPT_SERVICES/work-end-sound.sh