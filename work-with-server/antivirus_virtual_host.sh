#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Check virtual host for virus


# HELP
######

# $1 = virtual host short name, without suffix .local
# Example: forge1

# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

VIRTUAL_HOST_SHORT_NAME=$1

SITE_LOCAL_PATH="$HOME_WWW/$VIRTUAL_HOST_SHORT_NAME.local/www/"


# PROGRAM
#########

$HOME_SCRIPT_SERVICES/work-start.sh "Checking virtual host for virus: '$VIRTUAL_HOST_SHORT_NAME'"

$ECHO_COMMAND "Update antivirus program database"
$ECHO_COMMAND "sudo freshclam"
sudo freshclam

$ECHO_COMMAND "sudo clamscan -r -i $SITE_LOCAL_PATH"
sudo clamscan -r -i $SITE_LOCAL_PATH

$HOME_SCRIPT_SERVICES/work-end-summary.sh "Checking virtual host for virus: '$VIRTUAL_HOST_SHORT_NAME'"
$HOME_SCRIPT_SERVICES/work-end-sound.sh



#--remove