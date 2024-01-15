#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Make backup with sites


# HELP
######


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh


# PROGRAM
#########

$ECHO_START_WORK "backup projects files"

# sites
run_command "cd /home/backups/www"
run_command "find . -type f -mindepth 1 -mtime +45 -delete"

run_command "tar -cf aa_welcome_$DATE_SHORT.tar /var/www/html/aa_welcome/www"
run_command "tar -cf site_name_$DATE_SHORT.tar /var/www/html/site_name/www"

$ECHO_END_WORK "backup projects files"
