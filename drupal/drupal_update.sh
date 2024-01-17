#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Update Drupal 7.
# @todo check that files with .dot are not deleting
# @todo presave another files: robot.txt and so on


# HELP
######

# $1 = virtual host short name, without suffix ".local"
# Example: forge1


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

VIRTUAL_HOST_SHORT_NAME=$1
VIRTUAL_HOST_PATH="$HOME_WWW/$VIRTUAL_HOST_SHORT_NAME.local/www/"

# PROGRAM
#########

$HOME_SCRIPT_SERVICES/work-start.sh "Updating drupal on '$VIRTUAL_HOST_SHORT_NAME'"

$ECHO_COMMAND "cd $VIRTUAL_HOST_PATH"
cd $VIRTUAL_HOST_PATH

# $ECHO_COMMAND "cp .htaccess robots.txt ../"
# cp .htaccess robots.txt ../

$ECHO_COMMAND "sudo drush pm-update"
sudo drush pm-update

$ECHO_COMMAND "sudo $HOME_SHELL_SCRIPTS/drupal/chmod_and_chown_for_host.sh $VIRTUAL_HOST_SHORT_NAME"
sudo $HOME_SHELL_SCRIPTS/drupal/chmod_and_chown_for_host.sh $VIRTUAL_HOST_SHORT_NAME

# $ECHO_COMMAND "rm .htaccess robots.txt"
# rm .htaccess robots.txt

# $ECHO_COMMAND "mv ../.htaccess ../robots.txt ."
# mv ../.htaccess ../robots.txt .

$HOME_SCRIPT_SERVICES/work-end-summary.sh "Updating drupal on '$VIRTUAL_HOST_SHORT_NAME'"
$HOME_SCRIPT_SERVICES/work-end-sound.sh
