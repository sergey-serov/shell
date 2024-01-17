#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Download archives with backup data from my server


# HELP
######

# Check that local disk have enough space!
# $1 = date when backup was created.
# Format of date: `2016-06-21`

# CONFIG
########

. /home/sergey/forge/linux-scripts/script-services/useful-variables.sh

BACKUP_DATE=$1
TASK_NAME="Download archives for '$BACKUP_DATE' with backup data from my server"


# PROGRAM
#########

$SCRIPTS_SERVICES/work-start.sh "$TASK_NAME"
#todo add while + log $? about result + ls -la && du for downloaded file.
# www
run_command "scp -P $SERVER_PORT $SERVER_USER@$SERVER_IP:$SERVER_BACKUP_WWW/aa_welcome_$BACKUP_DATE.tar $LOCAL_SERVER_BACKUP_WWW/aa_welcome_$BACKUP_DATE.tar"
run_command "scp -P $SERVER_PORT $SERVER_USER@$SERVER_IP:$SERVER_BACKUP_WWW/site_name_$BACKUP_DATE.tar $LOCAL_SERVER_BACKUP_WWW/site_name_$BACKUP_DATE.tar"

# databases
run_command "scp -P $SERVER_PORT $SERVER_USER@$SERVER_IP:$SERVER_BACKUP_DATABASES/db_name_$BACKUP_DATE.gz $LOCAL_SERVER_BACKUP_DATABASES/db_name_$BACKUP_DATE.gz"

# configs
run_command "scp -P $SERVER_PORT $SERVER_USER@$SERVER_IP:$SERVER_BACKUP_CONFIGS/backup-config_$BACKUP_DATE.gz $LOCAL_SERVER_BACKUP_CONFIGS/backup-config_$BACKUP_DATE.gz"

# scripts
run_command "scp -P $SERVER_PORT $SERVER_USER@$SERVER_IP:$SERVER_BACKUP_SCRIPTS/backup-script_$BACKUP_DATE.gz $LOCAL_SERVER_BACKUP_SCRIPTS/backup-script_$BACKUP_DATE.gz"

$SCRIPTS_SERVICES/work-end-summary.sh "$TASK_NAME"
$SCRIPTS_SERVICES/work-end-sound.sh
