#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Dump MySQL database TO file


# HELP
######

# $1 = Database name
# Example: forge1

# $2 = s
# Optinal. If $2 == 's' without output common  messages


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh

DATABASE_NAME=$1

IS_SILENT=$2

# PROGRAM
#########

if [[ $IS_SILENT != s ]]; then
  $HOME_SCRIPT_SERVICES/work-start.sh "Dumping data from database to file '$DATABASE_NAME'"
fi

$ECHO_COMMAND "cd $HOME_ENTREPOT"
cd $HOME_ENTREPOT

$ECHO_COMMAND "mysqldump -hlocalhost -uroot -p$MYSQL_PASSWORD $DATABASE_NAME > \"$HOME_ENTREPOT/$DATABASE_NAME.sql\""
mysqldump -hlocalhost -uroot -p$MYSQL_PASSWORD $DATABASE_NAME > "$HOME_ENTREPOT/$DATABASE_NAME.sql"

$ECHO_COMMAND "tar -czf $DATABASE_NAME.tgz $DATABASE_NAME.sql"
tar -czf $DATABASE_NAME.tgz $DATABASE_NAME.sql

if [[ $IS_SILENT != s ]]; then
  $HOME_SCRIPT_SERVICES/work-end-summary.sh "Dumping data from database to file '$DATABASE_NAME'"
fi
