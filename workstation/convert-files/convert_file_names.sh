#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Convert file names from windows to linux


# HELP
######

# $1 = path to folder were files and dirs with 'invalid' symbols


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

PATH=$1


# PROGRAM
#########

$HOME_SCRIPT_SERVICES/work-start.sh "Checking virtual host for virus: '$PATH'"

$ECHO_COMMAND "cd $PATH"
cd $PATH

$ECHO_COMMAND "/usr/bin/convmv -r --notest -f windows-1251 -t UTF-8 *"
/usr/bin/convmv -r --notest -f windows-1251 -t UTF-8 *

$HOME_SCRIPT_SERVICES/work-end-summary.sh "Checking virtual host for virus: '$PATH'"
$HOME_SCRIPT_SERVICES/work-end-sound.sh