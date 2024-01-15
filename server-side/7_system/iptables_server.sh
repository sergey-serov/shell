#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Iptables rules for server
# todo: learn several cources about network and rewrite this file!!!
# Coursera + Udacity


# HELP
######
# ssh 29415
# dns 53
# nginx 80
# apache [uid=16410]
# yum 80, 443 -m owner --cmd-owner yum
# boinc *** [uid=16487]
# wget 80
# postfix 25
# ntp 123
# Google RECaptcha 443


# CONFIG
########
#. /root/1_warehouse/5_script_services/useful_variables.sh


# PROGRAM
#########

#
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
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# dns
# todo: is it really necessary --state for udp?
# todo: is it necessary -p tcp here?
iptables -A INPUT -i eth0 -p tcp --sport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -i eth0 -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -o eth0 -p udp --dport 53 -j ACCEPT

# http
iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

# ssh
iptables -A INPUT -i eth0 -p tcp --dport 29415 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 29415 -m state --state ESTABLISHED -j ACCEPT

# postfix
iptables -A INPUT -i eth0 -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT

# boinc
# now we make BIG advantage to IBM affiliate project
iptables -A INPUT -i eth0 -s www.worldcommunitygrid.org -j ACCEPT
iptables -A OUTPUT -o eth0 -d www.worldcommunitygrid.org -j ACCEPT

iptables -A INPUT -i eth0 -s secure.worldcommunitygrid.org -j ACCEPT
iptables -A OUTPUT -o eth0 -d secure.worldcommunitygrid.org -j ACCEPT

# iptables -A INPUT -i eth0 -p tcp --sport 31416 -s www.worldcommunitygrid.org -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -o eth0 -p tcp --dport 31416 -d www.worldcommunitygrid.org -m state --state NEW,ESTABLISHED -j ACCEPT

# iptables -A INPUT -i eth0 -p tcp --sport 31416 -s secure.worldcommunitygrid.org -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -o eth0 -p tcp --dport 31416 -d secure.worldcommunitygrid.org -m state --state NEW,ESTABLISHED -j ACCEPT

# iptables -A INPUT -i eth0 -p tcp --sport 80 -s www.worldcommunitygrid.org -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -o eth0 -p tcp --dport 80 -d www.worldcommunitygrid.org -m state --state NEW,ESTABLISHED -j ACCEPT

# iptables -A INPUT -i eth0 -p tcp --sport 80 -s secure.worldcommunitygrid.org -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -o eth0 -p tcp --dport 80 -d secure.worldcommunitygrid.org -m state --state NEW,ESTABLISHED -j ACCEPT

# iptables -A INPUT -i eth0 -p tcp --sport 443 -s www.worldcommunitygrid.org -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -o eth0 -p tcp --dport 443 -d www.worldcommunitygrid.org -m state --state NEW,ESTABLISHED -j ACCEPT

# iptables -A INPUT -i eth0 -p tcp --sport 443 -s secure.worldcommunitygrid.org -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -o eth0 -p tcp --dport 443 -d secure.worldcommunitygrid.org -m state --state NEW,ESTABLISHED -j ACCEPT

# ntp
iptables -A INPUT -i eth0 -p udp --sport 123 -s ntp1.hetzner.de,ntp2.hetzner.com,ntp3.hetzner.net -j ACCEPT
iptables -A OUTPUT -o eth0 -p udp --dport 123 -d ntp1.hetzner.de,ntp2.hetzner.com,ntp3.hetzner.net -j ACCEPT

# yum
# todo - define all servers names with repo

# Google RECaptcha
# todo - not easy topic, idealy make with NAME www.google.com
# nslookup google.com
# dig -t TXT _netblocks.google.com
# https://code.google.com/p/recaptcha/wiki/FirewallsAndRecaptcha
# 64.18.0.0/20
# 64.233.160.0/19
# 66.102.0.0/20
# 66.249.80.0/20
# 72.14.192.0/18
# 74.125.0.0/16
# 173.194.0.0/16
# 207.126.144.0/20
# 209.85.128.0/17
# 216.58.192.0/19
# 216.239.32.0/19
# iptables -A INPUT -i eth0 -s 64.18.0.0/20,64.233.160.0/19,66.102.0.0/20,66.249.80.0/20,72.14.192.0/18,74.125.0.0/16,173.194.0.0/16,207.126.144.0/20,209.85.128.0/17,216.58.192.0/19,216.239.32.0/19 -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -o eth0 -d 64.18.0.0/20,64.233.160.0/19,66.102.0.0/20,66.249.80.0/20,72.14.192.0/18,74.125.0.0/16,173.194.0.0/16,207.126.144.0/20,209.85.128.0/17,216.58.192.0/19,216.239.32.0/19 -m state --state NEW,ESTABLISHED -j ACCEPT

# not very big `hole`, but needs to be repaired after learning!
iptables -A INPUT -i eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -i eth0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT

# database.clamav.net
# iptables -A INPUT -i eth0 -p tcp --sport 80 -s database.clamav.net -m state --state ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -o eth0 -p tcp --dport 80 -d database.clamav.net -m state --state NEW,ESTABLISHED -j ACCEPT

# todo: backup server

# final LOG
iptables -A INPUT -i eth0  -m limit -j LOG --log-prefix "[fortress:unrule_input_ipv4] "
iptables -A OUTPUT -o eth0  -m limit -j LOG --log-prefix "[fortress:unrule_output_ipv4] "

# final DROP
iptables -A INPUT -i eth0 -j DROP
iptables -A OUTPUT -o eth0 -j DROP

#
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
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT

# http
ip6tables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -o eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

# RECaptcha
ip6tables -A INPUT -i eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -o eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

ip6tables -A INPUT -i eth0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -o eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT

# ssh
ip6tables -A INPUT -i eth0 -p tcp --dport 29415 -m state --state NEW,ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -o eth0 -p tcp --sport 29415 -m state --state ESTABLISHED -j ACCEPT

# postfix
ip6tables -A INPUT -i eth0 -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -o eth0 -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT

# final LOG
ip6tables -A INPUT -i eth0  -m limit -j LOG --log-prefix "[fortress:unrule_input_ipv6] "
ip6tables -A OUTPUT -o eth0  -m limit -j LOG --log-prefix "[fortress:unrule_output_ipv6] "

# final DROP
ip6tables -A INPUT -i eth0 -j DROP
ip6tables -A OUTPUT -o eth0 -j DROP

#
# End rules. Technics actions.
#

# print out
echo ''
echo '---- IPv4 -----'
echo ''
iptables -L -n -v
echo ''
echo '---- IPv6 -----'
echo ''
ip6tables -L -n -v
