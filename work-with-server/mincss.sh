#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Minimize css files in folder


# HELP
######

# $1 = path for search and minimizing


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

PATH_FOR_SEARCH=$1


# PROGRAM
#########

for file in `find $PATH_FOR_SEARCH -type f -name '*.css'`; do
  cat "$file" | $HOME_SHELL_SCRIPTS/hypertext/cssmin.py > "$file".min.temp.css;
  mv "$file".min.temp.css "$file";
done

