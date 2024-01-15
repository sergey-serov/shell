#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Clean iptables - if something was wrong


# HELP
######


# CONFIG
########
#. /root/1_warehouse/5_script_services/useful_variables.sh


# PROGRAM
#########

echo 'start clean'
# delete all current rules and user chains
iptables -F
iptables -X

# global policy (target by default)
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT



# delete all current rules and user chains
ip6tables -F
ip6tables -X

# global policy (target by default)
ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
