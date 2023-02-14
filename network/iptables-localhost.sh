#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Iptables rules for localhost workstation.


# HELP
######

# how to write rules:
# http://www.netfilter.org/documentation/HOWTO//packet-filtering-HOWTO-7.html
# http://wiki.centos.org/HowTos/Network/IPTables

# how to integrate with OS:
# http://stackoverflow.com/questions/30818931/debian-8-iptables-persistent
# 
# sudo apt-get install iptables-persistent
# sudo dpkg-reconfigure iptables-persistent

# https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol


# CONFIG
########

# $ ifconfig
ethernet_adapter_name='enp0s31f6'


# PROGRAM
#########

##
# IPv4
#

# delete all current rules and user chains
sudo iptables -F
sudo iptables -X

# global policy (target by default)
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP

# localhost
sudo iptables -v -A INPUT -i lo -j ACCEPT
sudo iptables -v -A OUTPUT -o lo -j ACCEPT

#
# rules for ports and programs
#

# ntpdate
sudo iptables -v -A INPUT -i $ethernet_adapter_name -p udp --sport 123 -j ACCEPT
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p udp --dport 123 -j ACCEPT

# dns
sudo iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 53 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

sudo iptables -v -A INPUT -i $ethernet_adapter_name -p udp --sport 53 -j ACCEPT
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p udp --dport 53 -j ACCEPT

# ssh my server
sudo iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport $my_server_ssh_port -m state --state ESTABLISHED -j ACCEPT
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport $my_server_ssh_port -m state --state NEW,ESTABLISHED -j ACCEPT

# ssh - other services
sudo iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

# http, https
sudo iptables -v -A INPUT -i $ethernet_adapter_name -p tcp -m multiport --sport 80,443 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp -m multiport --dport 80,443 -m state --state NEW,ESTABLISHED -j ACCEPT

# ftp
sudo iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 21 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT

# IRC
sudo iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 6667 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 6667 -m state --state NEW,ESTABLISHED -j ACCEPT

# ping todo
# sudo iptables -v -A INPUT -i $ethernet_adapter_name -p icmp --icmp-type 0 -m state --state ESTABLISHED -j ACCEPT
# sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED -j ACCEPT

# traceroute todo
# sudo iptables -v -A INPUT -i -p icmp --icmp-type 11 -m state --state ESTABLISHED,RELATED -j ACCEPT
# sudo iptables -v -A OUTPUT -o -p icmp --icmp-type 11 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# final LOG
sudo iptables -v -A INPUT -i $ethernet_adapter_name  -m limit -j LOG --log-prefix "[unrule input ipv4] "
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name  -m limit -j LOG --log-prefix "[unrule output ipv4] "
#  --log-ip-options --log-tcp-options

# final DROP
sudo iptables -v -A INPUT -i $ethernet_adapter_name -j DROP
sudo iptables -v -A OUTPUT -o $ethernet_adapter_name -j DROP


##
# IPv6
#

# delete all current rules and user chains
sudo ip6tables -F
sudo ip6tables -X

# global policy (target by default)
sudo ip6tables -P INPUT DROP
sudo ip6tables -P OUTPUT DROP
sudo ip6tables -P FORWARD DROP

# localhost
sudo ip6tables -v -A INPUT -i lo -j ACCEPT
sudo ip6tables -v -A OUTPUT -o lo -j ACCEPT

#
# rules for ports and programs
#

# ntpdate
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p udp --sport 123 -j ACCEPT
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p udp --dport 123 -j ACCEPT

# dns
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 53 -m state --state ESTABLISHED -j ACCEPT
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p udp --sport 53 -j ACCEPT
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p udp --dport 53 -j ACCEPT

# ssh my server
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport $my_server_ssh_port -m state --state ESTABLISHED -j ACCEPT
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport $my_server_ssh_port -m state --state NEW,ESTABLISHED -j ACCEPT

# ssh - other services
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

# http, https
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp -m multiport --sport 80,443 -m state --state ESTABLISHED -j ACCEPT
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp -m multiport --dport 80,443 -m state --state NEW,ESTABLISHED -j ACCEPT

# ftp
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 21 -m state --state ESTABLISHED -j ACCEPT
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT

# IRC
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 6667 -m state --state ESTABLISHED -j ACCEPT
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 6667 -m state --state NEW,ESTABLISHED -j ACCEPT

# ping todo
# sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -p icmp --icmp-type 0 -m state --state ESTABLISHED -j ACCEPT
# sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED -j ACCEPT

# traceroute todo
# sudo ip6tables -v -A INPUT -i -p icmp --icmp-type 11 -m state --state ESTABLISHED,RELATED -j ACCEPT
# sudo ip6tables -v -A OUTPUT -o -p icmp --icmp-type 11 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# final LOG
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name  -m limit -j LOG --log-prefix "[unrule input ipv6] "
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name  -m limit -j LOG --log-prefix "[unrule output ipv6] "
#  --log-ip-options --log-tcp-options

# final DROP
sudo ip6tables -v -A INPUT -i $ethernet_adapter_name -j DROP
sudo ip6tables -v -A OUTPUT -o $ethernet_adapter_name -j DROP

##
# End rules. Technics actions.
#

# print out
echo
echo "---- IPv4 -----"
echo

sudo iptables -L -n -v

echo
echo "---- IPv6 -----"
echo

sudo ip6tables -L -n -v

# TODO
######
# add "for" loop?
# add traceroute && ping


# WAREHOUSE
###########


