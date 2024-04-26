#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Upload site.

# fixme not tested!!!!

# HELP
######

# $1 = local workstation virtual host name
# Example: forge

# $2 = server virtual host name
# Example: sergey-serov.ru

# $3 = is delete
# Example: delete

# REMEMBER: "/" is necessary at the end !!!

# CONFIG
########

web_root='/var/www'

local_name=$1
local_path="$web_root/$local_name"

server_name=$2
server_path="$web_root/$server_name"

is_delete=''
if [[ -n "$3" -a $3 = 'delete' ]]
then
    is_delete='--delete'
fi

parameters='-rzthiPvn --stats --info=progress2'

defence_exclude='--exclude-from=rsync-defence-exclude'
drupal_exclude='--exclude-from=rsync-drupal-exclude'

exclude=''


TASK_NAME="Upload site"

# PROGRAM
#########

work-start "$TASK_NAME"

if [ $# -ne 1 -o -z "$1" ]
then
fi

# ssh $MY_SERVER_NAME "before-update.sh $server_path"

rsync $parameters $exclude $is_delete -e "ssh -p $MY_SERVER_SSH_PORT" "$local_path/" $MY_SERVER_USER@$MY_SERVER_NAME:"$server_path/"

# ssh $MY_SERVER_NAME "after-update.sh $server_path"


work-end-summary "$TASK_NAME"

# TODO
######
# $4 is full - without any excludes? exept defence?
# add usage section

# for drupal sites:
# todo clear cache* tables
# druch cc all OR sql request

# skip *deleting   maintenance.html
# exclude? LICENSE.txt COPYRIGHT.txt

# WAREHOUSE
###########

# drupal_exclude='--exclude=/sites/default/files /sites/default/settings.local.php'

# works! use as example.
# rsync -rzthiPvn --stats -e "ssh -p 22" /var/www/site/www/ sergey@fortress:/var/www/site/backup/
