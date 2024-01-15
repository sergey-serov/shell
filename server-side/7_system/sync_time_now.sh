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

run_command "ntpdate -d it.pool.ntp.org"
