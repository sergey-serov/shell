#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Recive file from server
# File must be in "Entrepot" on server


# HELP
######

# $1 = file name 


# CONFIG
########
. /home/sergey/forge/linux-scripts/script-services/useful-variables.sh

FILE_NAME=$1
FILE_PATH=$ENTREPOT

FILE_PATH_REMOTE=$SERVER_ENTREPOT/$FILE_NAME

IS_SILENT=$2

TASK_NAME="Reciving file '$FILE_NAME' from server"

# PROGRAM
#########

if [[ $IS_SILENT != s ]]; then
	$SCRIPTS_SERVICES/work-start.sh "$TASK_NAME"
fi

run_command "scp -P $SERVER_PORT $SERVER_USER@$SERVER_IP:$FILE_PATH_REMOTE $FILE_PATH"

if [[ $IS_SILENT != s ]]; then
	$SCRIPTS_SERVICES/work-end-summary.sh "$TASK_NAME"
	$SCRIPTS_SERVICES/work-end-sound.sh
fi
