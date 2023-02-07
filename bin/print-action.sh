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

echo '-----------'
echo "[`date +"%T"`]: $action"


# TODO
######

# WAREHOUSE
###########