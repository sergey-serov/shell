#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Echo current command
# On remote server


# HELP
######

# $1 = string


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh

CURRENT_COMMAND=$1


# PROGRAM
#########

echo -e "$GREEN----------------------------------------------------------------------------------------------------------------------------$COLOR_END"
echo -e "$GREEN[`date "+%Y.%m.%d %T"`]: $CURRENT_COMMAND $COLOR_END"
#echo -e "$GREEN[$DATE]: $CURRENT_COMMAND $COLOR_END"



