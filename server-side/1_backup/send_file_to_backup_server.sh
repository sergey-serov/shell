#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Send file to backup server


# HELP
######
# $1 - filename
# $2 - destination dir


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh


# PROGRAM

run_command "scp $1 backup_server:$2/$1"
