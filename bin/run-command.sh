#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Print and run command.


# HELP
######

# $1 = command


# CONFIG
########

current_command=$1

# PROGRAM
#########

echo -e "$YELLOW-----------$COLOR_END"
echo -e "$YELLOW[`date +"%T"`]: $current_command $COLOR_END"
$current_command


# TODO
######

# WAREHOUSE
###########
