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

/root/1_warehouse/7_system/iptables_server.sh

run_command "postfix stop"

run_command "service boinc-client start"
