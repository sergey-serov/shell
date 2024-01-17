#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Download site files from my
# Full or only part - depend on third argument


# HELP
######

# $1 = virtual host short name, without suffix .local
# Example: forge1

# $2 = remote virtual host FULL name
# Example: sergey-serov.ru

# $3 = 'full' Optional!
# Download all site with user data


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

VIRTUAL_HOST_SHORT_NAME=$1

SITE_LOCAL_PATH="$HOME_WWW/$VIRTUAL_HOST_SHORT_NAME.local/www/"
SITE_REMOTE_PATH="/var/www/html/$2/www/"
IS_FULL=$3

EXCLUDE="--exclude=/sites/default/files/videos/*"
PARAMETERS="-rltvhiP"

if [[ "$IS_FULL" == "full" ]]; then
	EXCLUDE=""
	PARAMETERS="-avhiP"
fi


# PROGRAM
#########

$HOME_SCRIPT_SERVICES/work-start.sh "Downloading site '$VIRTUAL_HOST_SHORT_NAME'"

$ECHO_COMMAND "sudo rsync $PARAMETERS --stats $EXCLUDE -e ssh $SERVER_USER@$SERVER_IP:$SITE_REMOTE_PATH $SITE_LOCAL_PATH"
sudo rsync $PARAMETERS --stats $EXCLUDE -e ssh $SERVER_USER@$SERVER_IP:$SITE_REMOTE_PATH $SITE_LOCAL_PATH

$ECHO_COMMAND "/home/sergey/forge-home/1_shell_scripts/system/antivirus_virtual_host.sh $VIRTUAL_HOST_SHORT_NAME"
/home/sergey/forge-home/1_shell_scripts/system/antivirus_virtual_host.sh $VIRTUAL_HOST_SHORT_NAME

$ECHO_COMMAND "sudo $HOME_SHELL_SCRIPTS/drupal/chmod_and_chown_for_host.sh $VIRTUAL_HOST_SHORT_NAME"
sudo $HOME_SHELL_SCRIPTS/drupal/chmod_and_chown_for_host.sh $VIRTUAL_HOST_SHORT_NAME

$HOME_SCRIPT_SERVICES/work-end-summary.sh "Downloading site '$VIRTUAL_HOST_SHORT_NAME'"
$HOME_SCRIPT_SERVICES/work-end-sound.sh
