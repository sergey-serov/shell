#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Make backup of system configs and my bash scripts


# HELP
######


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh


# PROGRAM
#########

$ECHO_START_WORK "backup config and scripts files"

run_command "cd /home/backups/script"
run_command "find . -type f -mindepth 1 -mtime +45 -delete"

# scripts
run_command "tar -czf backup-script_$DATE_SHORT.gz /root/1_warehouse"
$HOME_SHELL_SCRIPTS/1_backup/send_file_to_backup_server.sh backup-script_$DATE_SHORT.gz script

# configs
run_command "cd ../_temp"

yum repolist -v > repolist.txt
yum list installed > list-installed.txt

crontab -l > crontab.txt

run_command "tar -cf etc.tar /etc"
run_command "tar -cf root.tar /root/.bash_history /root/.bashrc /root/.mysql_history /root/.my.cnf /root/.config /root/.ssh /root/.vim /root/.viminfo"

run_command "tar -czf ../config/backup-config_$DATE_SHORT.gz repolist.txt list-installed.txt crontab.txt etc.tar root.tar"
run_command "rm repolist.txt list-installed.txt crontab.txt etc.tar root.tar"

run_command "cd ../config"
run_command "find . -type f -mindepth 1 -mtime +60 -delete"
$HOME_SHELL_SCRIPTS/1_backup/send_file_to_backup_server.sh backup-config_$DATE_SHORT.gz config


$ECHO_END_WORK "backup config and scripts files"
