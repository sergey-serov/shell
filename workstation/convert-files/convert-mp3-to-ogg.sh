#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Convert all mp3 files to ogg


# HELP
######

# $1 = path to directory with mp3 files
# http://askubuntu.com/questions/147944/bulk-batch-convert-mp3-files-to-ogg-via-command-line
# cd to directory before

# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

MP3_DIRECTIRY=$1

# PROGRAM
#########

$ECHO_COMMAND "cd $MP3_DIRECTIRY"
cd $MP3_DIRECTIRY


for file in *.mp3
	# $ECHO_COMMAND "do ffmpeg -i \"${file}\" \"${file/%mp3/ogg}\""
	do ffmpeg -i "${file}" "${file/%mp3/ogg}"
done