#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Format pretty output summary about starting script


# HELP
######

# $1 = which work was started


# CONFIG
########

WORK="$*"


# PROGRAM
#########

echo -e "$NAVY-----------$COLOR_END"
echo -e "$NAVY[`date +"%T"`]: $WORK started... $COLOR_END"
# echo "$WORK started" | festival --tts

# TODO
######

# WAREHOUSE
###########