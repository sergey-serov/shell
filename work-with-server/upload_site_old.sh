#! /bin/bash

# author: Sergey Serov

# todo clear cache* tables
# druch cc all OR sql request
# skip *deleting   maintenance.html

# DESCRIPTION
#############
# Upload site files from my local workstation


# HELP
######

# $1 = virtual host short name, without suffix .local
# Example: forge1

# $2 = remote virtual host FULL name
# Example: sergey-serov.ru

# $3 = 'full' Optional!
# Upload all site with user data
# We may type something else here if need fourth parameter

# $4 = database name. Optional!
# Copy database from local to server


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

SITE_LOCAL_SHORT_NAME=$1
SITE_REMOTE_FULL_NAME=$2
IS_FULL=$3
IS_DELETE="--delete"
DATABASE_NAME=$4

SITE_LOCAL_PATH="$HOME_WWW/$SITE_LOCAL_SHORT_NAME.local/www/"
SITE_REMOTE_PATH="/var/www/html/$SITE_REMOTE_FULL_NAME/www/"

PARAMETERS="-rzthiPv"
# -p was removed
EXCLUDE="--exclude=/sites/default/files /sites/default/settings.local.php"

if [[ "$IS_FULL" == "full" ]]; then
	EXCLUDE="--exclude=/sites/default/settings.local.php"
  IS_DELETE=""
fi

# PROGRAM
#########

$HOME_SCRIPT_SERVICES/work-start.sh "Uploading site '$SITE_LOCAL_SHORT_NAME'"

$ECHO_COMMAND "ssh my \"/root/1_warehouse/3_update_site/before-update.sh $SITE_REMOTE_FULL_NAME\""
ssh my "/root/1_warehouse/3_update_site/before-update.sh $SITE_REMOTE_FULL_NAME"

$ECHO_COMMAND "sudo rsync $PARAMETERS $EXCLUDE_FILE_FOR_RSYNC $EXCLUDE $IS_DELETE -n --stats -e \"ssh -p $SERVER_PORT\" $SITE_LOCAL_PATH $SERVER_USER@$SERVER_IP:$SITE_REMOTE_PATH"
sudo rsync $PARAMETERS $EXCLUDE_FILE_FOR_RSYNC $EXCLUDE $IS_DELETE --stats -e "ssh -p $SERVER_PORT" $SITE_LOCAL_PATH $SERVER_USER@$SERVER_IP:$SITE_REMOTE_PATH

# $ECHO_COMMAND "scp -P $SERVER_PORT $SITE_LOCAL_PATH.htaccess $SERVER_USER@$SERVER_IP:$SITE_REMOTE_PATH.htaccess"
# scp -P $SERVER_PORT $SITE_LOCAL_PATH.htaccess $SERVER_USER@$SERVER_IP:$SITE_REMOTE_PATH.htaccess

if [ ! -z "$4" ]
  then
  	$ECHO_COMMAND "We have fourth parametr and must update database too."
  	$ECHO_COMMAND "$HOME_SHELL_SCRIPTS/mysql/copy_from_local.sh $DATABASE_NAME"
    $HOME_SHELL_SCRIPTS/mysql/copy_from_local.sh $DATABASE_NAME s
fi

$ECHO_COMMAND "ssh my \"/root/1_warehouse/3_update_site/after-update.sh $SITE_REMOTE_FULL_NAME\""
ssh my "/root/1_warehouse/3_update_site/after-update.sh $SITE_REMOTE_FULL_NAME"

$HOME_SCRIPT_SERVICES/work-end-summary.sh "Uploading site '$SITE_LOCAL_SHORT_NAME'"
$HOME_SCRIPT_SERVICES/work-end-sound.sh




# PARAMETERS="-rltvhiP"
# PARAMETERS="-avhiP"