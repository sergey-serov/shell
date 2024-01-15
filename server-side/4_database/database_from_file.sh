#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Restore MySQL database FROM file


# HELP
######

# $1 = Database name
# Example: forge1


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh

DATABASE_NAME=$1

IS_SILENT=$2

# PROGRAM
#########

if [[ $IS_SILENT != s ]]; then
	$HOME_SCRIPT_SERVICES/work-start.sh "Restoring data from file to database '$DATABASE_NAME'"
fi


QUERY=`/usr/bin/mysql -uroot -pPASSWORD<<SQL
DROP DATABASE $DATABASE_NAME;
CREATE DATABASE $DATABASE_NAME;
quit
SQL`

if [[ -n $QUERY ]]; then
	# if error
	$ECHO_COMMAND $QUERY
fi

$ECHO_COMMAND "cd $HOME_ENTREPOT"
cd $HOME_ENTREPOT


$ECHO_COMMAND "tar -xzf $DATABASE_NAME.tgz"
tar -xzf $DATABASE_NAME.tgz


$ECHO_COMMAND "mysql -hlocalhost -uroot -p$MYSQL_PASSWORD $DATABASE_NAME < \"$HOME_ENTREPOT/$DATABASE_NAME.sql\""
mysql -hlocalhost -uroot -p$MYSQL_PASSWORD $DATABASE_NAME < "$HOME_ENTREPOT/$DATABASE_NAME.sql"

if [[ $IS_SILENT != s ]]; then
	$HOME_SCRIPT_SERVICES/work-end-summary.sh "Restoring data from file to database '$DATABASE_NAME'"
fi
