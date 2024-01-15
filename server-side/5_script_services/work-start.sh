#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Format pretty output summary about starting script


# HELP
######

# $1 = which work was started


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh

WORK="$*"


# PROGRAM
#########

echo -e "$GREEN----------------------------------------------------------------------------------------------------------------------------$COLOR_END"
echo -e "$GREEN[`date +"%T"`]: $WORK started $COLOR_END"
# echo "$WORK started" | festival --tts
