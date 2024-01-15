#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Make dump mysql databases


# HELP
######


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh


# PROGRAM
#########

$ECHO_START_WORK "backup mysql databases"

# make mysql dump
$HOME_SHELL_SCRIPTS/4_database/database_to_file.sh db_name

# move files to local storage
run_command "cd /home/backups/mysql"
run_command "find . -type f -mindepth 1 -mtime +7 -delete"

run_command "mv $HOME_ENTREPOT/db_name.tgz db_name_$DATE_SHORT.gz"

# copy files to back server
$HOME_SHELL_SCRIPTS/1_backup/send_file_to_backup_server.sh db_name_$DATE_SHORT.gz mysql

$ECHO_END_WORK "backup mysql databases"

# for every database separate process and file
# drush cache-clear
# http://dev.mysql.com/doc/refman/5.5/en/mysqldump.html
# --lock-tables
# --lock-all-tables
# mysql --one-database db_to_restore < full.dump
# http://dev.mysql.com/doc/refman/5.5/en/mysqldump.html

# /root/1_warehouse/1_backup/make_mysqldump.sh >> /root/1_warehouse/1_backup/make_mysqldump.log 2>&1
