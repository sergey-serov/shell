#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Run script is button was pressed


# HELP
######


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

# PROGRAM
#########

PROJECT_STATUS=`boinccmd --get_project_status | grep 'suspended via GUI: yes'`

if [[ $PROJECT_STATUS == '   suspended via GUI: yes' ]]; then
	#  we need to resume
#	echo "World Community Grid was resumed" | festival --tts
	boinccmd --project http://www.worldcommunitygrid.org/ resume
else
	# we need to suspend
#	echo "World Community Grid was suspended" | festival --tts
	boinccmd --project http://www.worldcommunitygrid.org/ suspend
fi
