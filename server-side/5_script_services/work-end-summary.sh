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
# let "EXECUTION_TIME=`date +%s` - $START_TIME"

# PROGRAM
#########

echo -e "$GREEN----------------------------------------------------------------------------------------------------------------------------$COLOR_END"
echo -e "$GREEN[`date +"%T"`]: $WORK complete. $COLOR_END"
# echo "$WORK complete" | festival --tts
echo -e "$GREEN----------------------------------------------------------------------------------------------------------------------------$COLOR_END"
