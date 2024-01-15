#!/bin/bash

echo '---------------IPv4----------------'
iptables -L -n -v
echo '---------------IPv6----------------'
ip6tables -L -n -v

echo '-------------MESSAGES--------------'
tail -n 20 /var/log/messages
echo '-------------POSTFIX---------------'
tail -n 20 /var/log/maillog
echo '---------------NET-----------------'
netstat -nlap | grep ':25'
netstat -nlap | grep 'smtp'
netstat -nlap | grep 'postfix'
