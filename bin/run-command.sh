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

echo '-----------'
echo "[`date +"%T"`]: $current_command"
$current_command


# TODO
######

# WAREHOUSE
###########
