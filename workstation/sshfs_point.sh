#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# SSHFS connect


# HELP
######

# $1 = remote path
# Example: /etc/nginx

# $1 = command: start|stop
# Example: start


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

REMOTE_PATH=$1
COMMAND=$2

$HOME_SCRIPT_SERVICES/work-start.sh "sshfs $COMMAND"

$ECHO_COMMAND ""

if [[ "$COMMAND" == "start" ]]; then
	$ECHO_COMMAND "sshfs root@my:$REMOTE_PATH $HOME_SSHFS_POINT"
	sshfs root@my:$REMOTE_PATH $HOME_SSHFS_POINT
fi

if [[ "$COMMAND" == "stop" ]]; then
	$ECHO_COMMAND "fusermount -u $HOME_SSHFS_POINT"
	fusermount -u $HOME_SSHFS_POINT
fi

$HOME_SCRIPT_SERVICES/work-end-summary.sh "sshfs $COMMAND complete"
$HOME_SCRIPT_SERVICES/work-end-sound.sh