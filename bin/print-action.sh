#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Just print.
# For command or any describe message before action.

# It may be used when command complex and standard 
# function for print and run command not works properly.
# Also provide pretty way to add more info into script.


# HELP
######

# $1 = command


# CONFIG
########

action=$1


# PROGRAM
#########

echo -e "$MAGENTA-----------$COLOR_END"
echo -e "$MAGENTA[`date +"%T"`]: $action $COLOR_END"


# TODO
######

# WAREHOUSE
###########