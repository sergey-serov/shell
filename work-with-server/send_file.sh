#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Send file from local workstation to server
# File must be in "Entrepot" 
# $HOME_ENTREPOT="/home/sergey/forge-home/3_entrepot"


# HELP
######

# $1 = file name 


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

FILE_NAME=$1
FILE_PATH=$HOME_ENTREPOT/$FILE_NAME

FILE_PATH_REMOTE=$HOME_SERVER_ENTREPOT/$FILE_NAME

IS_SILENT=$2

# PROGRAM
#########

if [[ $IS_SILENT != s ]]; then
	$HOME_SCRIPT_SERVICES/work-start.sh "Sending file '$FILE_NAME'"
fi

$ECHO_COMMAND "scp -P $SERVER_PORT $FILE_PATH $SERVER_USER@$SERVER_IP:$FILE_PATH_REMOTE"
scp -P $SERVER_PORT $FILE_PATH $SERVER_USER@$SERVER_IP:$FILE_PATH_REMOTE

if [[ $IS_SILENT != s ]]; then
	$HOME_SCRIPT_SERVICES/work-end-summary.sh "Sending file '$FILE_NAME'"
	$HOME_SCRIPT_SERVICES/work-end-sound.sh
fi