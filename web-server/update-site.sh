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

# $2 = local workstation virtual host name
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

rsync_parameters='-rzthiPv'

defence_exclude=
--exclude-from=FILE

drupal_exclude='--exclude=/sites/default/files /sites/default/settings.local.php'


TASK_NAME="Upload site"

# PROGRAM
#########

work-start "$TASK_NAME"

if [ $# -ne 1 -o -z "$1" ]
then
fi

rsync -rzthiPvn --stats --info=progress2 -e "ssh -p $MY_SERVER_SSH_PORT" "$local_path/" $MY_SERVER_USER@$MY_SERVER_NAME:"$server_path/"


work-end-summary "$TASK_NAME"

# TODO
######
#ssh my "before-update.sh $server_path"
#ssh my "after-update.sh $server_path"
# $4 is full - without any excludes

# for drupal sites:
# todo clear cache* tables
# druch cc all OR sql request

# skip *deleting   maintenance.html
# exclude? LICENSE.txt COPYRIGHT.txt

# WAREHOUSE
###########


