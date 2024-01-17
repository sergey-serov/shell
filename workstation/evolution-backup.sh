#! /bin/bash

# author: Sergey Serov
# www.sergey-serov.ru


# DESCRIPTION
#############
# Configure new workstation system


# HELP
######


# CONFIG
########
. ~/forge/linux-scripts/scripts-helpers/useful-variables.sh


# PROGRAM
#########

ask_confirmation "backup all data on workstation"

run_command "mkdir $HOME/evolution"
run_command "mkdir $HOME/evolution/all-copies"
run_command "cd $HOME/evolution"

crontab -l > ./all-copies/crontab
mysqldump -hlocalhost -uroot -p$MYSQL_PASSWORD --all-databases > ./all-copies/all-databases.sql

tar -czf evolution-backup.tgz -T $LINUX_SCRIPTS/system/evolution-list-files.txt all-copies/*
