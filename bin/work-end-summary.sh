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

echo '-----------'
echo -e "$NAVY[`date +"%T"`]: $WORK complete.$COLOR_END"
# echo "$WORK complete" | festival --tts
echo -e "$NAVY-----------$COLOR_END"

# TODO
######

# WAREHOUSE
###########