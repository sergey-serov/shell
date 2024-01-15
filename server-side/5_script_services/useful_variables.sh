#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Variables for another scripts
# Just add this string
# . /root/1_warehouse/5_script_services/useful_variables.sh

# Also create file with private variables like $MYSQL_PASSWORD


# HELP
######

# Be happy


# CONFIG
########
DATE=`date "+%Y-%m-%d_%H-%M"`
DATE_SHORT=`date "+%Y-%m-%d"`
START_TIME=`date +%s`

HOME_SHELL_SCRIPTS="/root/1_warehouse"

HOME_SCRIPT_SERVICES=$HOME_SHELL_SCRIPTS/5_script_services
ECHO_COMMAND="$HOME_SCRIPT_SERVICES/echo_command.sh"
ECHO_START_WORK="$HOME_SCRIPT_SERVICES/echo_start_work.sh"
ECHO_END_WORK="$HOME_SCRIPT_SERVICES/echo_end_work.sh"

HOME_ENTREPOT="/root/4_entrepot"

HOME_WWW="/var/www/html"


# colors
COLOR_END='\e[0m'

BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
NAVY='\e[0;34m'
PURPLE='\e[0;35m'
TURQUOISE='\e[0;36m'
WHITE='\e[0;37m'


# PROGRAM
#########

# Echo which command and run it
run_command() {
  $ECHO_COMMAND "$1"
  $1
}

# run jpegoptim and correct owner and permissions for optimized file
optimize_jpeg() {
  jpegoptim --strip-all -t -v $1;
  chown apache:apache $1;
  chmod 644 $1;
}

# run optipng and correct owner and permissions for optimized file
optimize_png() {
  optipng -preserve $1;
  chown apache:apache $1;
  chmod 644 $1;
}
