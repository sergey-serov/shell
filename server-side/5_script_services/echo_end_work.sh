#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Echo end work
# On remote server


# HELP
######

# $1 = string


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh

WORK=$1


# PROGRAM
#########

echo -e "$TURQUOISE<<<$COLOR_END"
echo -e "$TURQUOISEEnd $WORK at $DATE $COLOR_END"
echo -e "$TURQUOISE----------------------------------------------------------------------------------------------------------------------------$COLOR_END"
