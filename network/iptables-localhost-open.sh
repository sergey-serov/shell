#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# For a not long time open everething.
# Stop local development web server.


# HELP
######


# CONFIG
########


# PROGRAM
#########

# stop local web server
sudo service apache2 stop
sudo service mysql stop

##
# IPv4
#

# delete all current rules and user chains
iptables -F
iptables -X

# global policy (target by default)
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# localhost
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT


##
# IPv6
#

# delete all current rules and user chains
ip6tables -F
ip6tables -X

# global policy (target by default)
ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT

# localhost
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT


##
# End rules. Print out what we have now.
#

echo
echo '---- IPv4 -----'
echo
iptables -L -n -v
echo
echo '---- IPv6 -----'
echo
ip6tables -L -n -v
