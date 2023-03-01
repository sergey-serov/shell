#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Just print command that will be run after.
# It is useful when command is complex with stream redirections 
# and standard function for printing and running command not works properly.


# HELP
######

# $1 = command


# CONFIG
########

command=$1


# PROGRAM
#########

echo -e "$MAGENTA-----------$COLOR_END"
echo -e "$MAGENTA[`date +"%T"`]: $command $COLOR_END"


# TODO
######

# WAREHOUSE
###########
