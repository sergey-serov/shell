#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Copy MySQL database from server to local workstation


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
  $HOME_SCRIPT_SERVICES/work-start.sh "Copying database $DATABASE_NAME from server to local workstation"
fi

$ECHO_COMMAND "ssh my \"/root/1_warehouse/4_database/database_to_file.sh $DATABASE_NAME\""
ssh my "/root/1_warehouse/4_database/database_to_file.sh $DATABASE_NAME"

$ECHO_COMMAND "$HOME_SHELL_SCRIPTS/recive_file.sh \"$DATABASE_NAME.tgz\" s"
$HOME_SHELL_SCRIPTS/recive_file.sh "$DATABASE_NAME.tgz" s

$ECHO_COMMAND "cd $HOME_ENTREPOT"
cd $HOME_ENTREPOT

$ECHO_COMMAND "tar -xzf \"$DATABASE_NAME.tgz\""
tar -xzf "$DATABASE_NAME.tgz"

$ECHO_COMMAND "$HOME_SHELL_SCRIPTS/mysql/database_from_file.sh $DATABASE_NAME s"
$HOME_SHELL_SCRIPTS/mysql/database_from_file.sh $DATABASE_NAME s

if [[ $IS_SILENT != s ]]; then
  $HOME_SCRIPT_SERVICES/work-end-summary.sh "Copying database $DATABASE_NAME from server to local workstation"
  $HOME_SCRIPT_SERVICES/work-end-sound.sh
fi