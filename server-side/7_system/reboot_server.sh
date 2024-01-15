#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Reboot server - stop programs and reboot


# HELP
######


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh


# PROGRAM
#########

# postfix
###run_command "postfix stop"

# boinc
run_command "service boinc-client stop"

# web daemons
run_command "service nginx stop"
run_command "service httpd stop"
run_command "service mysql stop"
run_command "shutdown -r now"
