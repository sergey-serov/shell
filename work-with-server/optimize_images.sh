#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Optimize images - jpg and png


# HELP
######

# $1 = path to dir


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

PATH_DIR=$1


# PROGRAM
#########

run_command "sudo chown -R sergey:sergey $PATH_DIR"

$ECHO_COMMAND "Total file size before:"
run_command "du -s $PATH_DIR"

$ECHO_COMMAND "Optimize jpeg in $PATH_DIR"

find $PATH_DIR -type f -name '*.jpg' -exec jpegoptim --strip-all -t -v {} \;

$ECHO_COMMAND "Optimize png in $PATH_DIR"

find $PATH_DIR -type f -name '*.png' -exec optipng -preserve {} \;

$ECHO_COMMAND "Optimize gif in $PATH_DIR"

find $PATH_DIR -type f -name '*.gif' -exec optipng -preserve {} \;

$ECHO_COMMAND "Total file size after:"
run_command "du -s $PATH_DIR"
