#! /bin/bash

# author: Sergey Serov


# DESCRIPTION
#############

# Copy MySQL database from local to server


# HELP
######

# $1: database name
# Example: forge1

# $2 = Is it necessary to output verbouse information about process
# Example: s


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

DATABASE_NAME=$1

IS_SILENT=$2


# PROGRAM
#########

if [[ $IS_SILENT != s ]]; then
	$HOME_SCRIPT_SERVICES/work-start.sh "Copying database $DATABASE_NAME from local workstation"
fi

$ECHO_COMMAND "$HOME_SHELL_SCRIPTS/mysql/database_to_file.sh $DATABASE_NAME s"
$HOME_SHELL_SCRIPTS/mysql/database_to_file.sh $DATABASE_NAME s

$ECHO_COMMAND "cd $HOME_ENTREPOT"
cd $HOME_ENTREPOT

$ECHO_COMMAND "tar -czf \"$DATABASE_NAME.tgz\" \"$DATABASE_NAME.sql\""
tar -czf "$DATABASE_NAME.tgz" "$DATABASE_NAME.sql"

$ECHO_COMMAND "$HOME_SHELL_SCRIPTS/send_file.sh \"$DATABASE_NAME.tgz\" s"
$HOME_SHELL_SCRIPTS/send_file.sh "$DATABASE_NAME.tgz" s

$ECHO_COMMAND "ssh my \"/root/1_warehouse/4_database/database_from_file.sh $DATABASE_NAME\""
ssh my "/root/1_warehouse/4_database/database_from_file.sh $DATABASE_NAME"

if [[ $IS_SILENT != s ]]; then
	$HOME_SCRIPT_SERVICES/work-end-summary.sh "Copying database $DATABASE_NAME from local workstation"
	$HOME_SCRIPT_SERVICES/work-end-sound.sh
fi