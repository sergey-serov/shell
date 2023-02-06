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
iptables -F
iptables -X

# global policy (target by default)
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# localhost
iptables -v -A INPUT -i lo -j ACCEPT
iptables -v -A OUTPUT -o lo -j ACCEPT

#
# rules for ports and programs
#

# ntpdate
iptables -v -A INPUT -i $ethernet_adapter_name -p udp --sport 123 -j ACCEPT
iptables -v -A OUTPUT -o $ethernet_adapter_name -p udp --dport 123 -j ACCEPT

# dns
iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -v -A INPUT -i $ethernet_adapter_name -p udp --sport 53 -j ACCEPT
iptables -v -A OUTPUT -o $ethernet_adapter_name -p udp --dport 53 -j ACCEPT

# ssh my server
iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport $my_server_ssh_port -m state --state ESTABLISHED -j ACCEPT
iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport $my_server_ssh_port -m state --state NEW,ESTABLISHED -j ACCEPT

# ssh - other services
iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

# http, https
iptables -v -A INPUT -i $ethernet_adapter_name -p tcp -m multiport --sport 80,443 -m state --state ESTABLISHED -j ACCEPT
iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp -m multiport --dport 80,443 -m state --state NEW,ESTABLISHED -j ACCEPT

# ftp
iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 21 -m state --state ESTABLISHED -j ACCEPT
iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT

# IRC
iptables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 6667 -m state --state ESTABLISHED -j ACCEPT
iptables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 6667 -m state --state NEW,ESTABLISHED -j ACCEPT

# ping todo
# iptables -v -A INPUT -i $ethernet_adapter_name -p icmp --icmp-type 0 -m state --state ESTABLISHED -j ACCEPT
# iptables -v -A OUTPUT -o $ethernet_adapter_name -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED -j ACCEPT

# traceroute todo
# iptables -v -A INPUT -i -p icmp --icmp-type 11 -m state --state ESTABLISHED,RELATED -j ACCEPT
# iptables -v -A OUTPUT -o -p icmp --icmp-type 11 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# final LOG
iptables -v -A INPUT -i $ethernet_adapter_name  -m limit -j LOG --log-prefix "[unrule input ipv4] "
iptables -v -A OUTPUT -o $ethernet_adapter_name  -m limit -j LOG --log-prefix "[unrule output ipv4] "
#  --log-ip-options --log-tcp-options

# final DROP
iptables -v -A INPUT -i $ethernet_adapter_name -j DROP
iptables -v -A OUTPUT -o $ethernet_adapter_name -j DROP


##
# IPv6
#

# delete all current rules and user chains
ip6tables -F
ip6tables -X

# global policy (target by default)
ip6tables -P INPUT DROP
ip6tables -P OUTPUT DROP
ip6tables -P FORWARD DROP

# localhost
ip6tables -v -A INPUT -i lo -j ACCEPT
ip6tables -v -A OUTPUT -o lo -j ACCEPT

#
# rules for ports and programs
#

# ntpdate
ip6tables -v -A INPUT -i $ethernet_adapter_name -p udp --sport 123 -j ACCEPT
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p udp --dport 123 -j ACCEPT

# dns
ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 53 -m state --state ESTABLISHED -j ACCEPT
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

ip6tables -v -A INPUT -i $ethernet_adapter_name -p udp --sport 53 -j ACCEPT
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p udp --dport 53 -j ACCEPT

# ssh my server
ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport $my_server_ssh_port -m state --state ESTABLISHED -j ACCEPT
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport $my_server_ssh_port -m state --state NEW,ESTABLISHED -j ACCEPT

# ssh - other services
ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

# http, https
ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp -m multiport --sport 80,443 -m state --state ESTABLISHED -j ACCEPT
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp -m multiport --dport 80,443 -m state --state NEW,ESTABLISHED -j ACCEPT

# ftp
ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 21 -m state --state ESTABLISHED -j ACCEPT
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT

# IRC
ip6tables -v -A INPUT -i $ethernet_adapter_name -p tcp --sport 6667 -m state --state ESTABLISHED -j ACCEPT
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p tcp --dport 6667 -m state --state NEW,ESTABLISHED -j ACCEPT

# ping todo
# ip6tables -v -A INPUT -i $ethernet_adapter_name -p icmp --icmp-type 0 -m state --state ESTABLISHED -j ACCEPT
# ip6tables -v -A OUTPUT -o $ethernet_adapter_name -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED -j ACCEPT

# traceroute todo
# ip6tables -v -A INPUT -i -p icmp --icmp-type 11 -m state --state ESTABLISHED,RELATED -j ACCEPT
# ip6tables -v -A OUTPUT -o -p icmp --icmp-type 11 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# final LOG
ip6tables -v -A INPUT -i $ethernet_adapter_name  -m limit -j LOG --log-prefix "[unrule input ipv6] "
ip6tables -v -A OUTPUT -o $ethernet_adapter_name  -m limit -j LOG --log-prefix "[unrule output ipv6] "
#  --log-ip-options --log-tcp-options

# final DROP
ip6tables -v -A INPUT -i $ethernet_adapter_name -j DROP
ip6tables -v -A OUTPUT -o $ethernet_adapter_name -j DROP

##
# End rules. Technics actions.
#

# print out
echo ''
p '---- IPv4 -----'
echo ''
iptables -L -n -v
echo ''
p '---- IPv6 -----'
echo ''
ip6tables -L -n -v

# TODO
######
# add "for" loop?


# WAREHOUSE
###########


