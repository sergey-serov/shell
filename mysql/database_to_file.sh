#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Dump MySQL database to file.


# HELP
######

# $1 = Database name
# $2 = File name

# Exit codes:
# 1 - not correct number of parameters
# 2 - file exist and must be kept

# Example: ./database_to_file.sh forge /tmp/init.sql


# CONFIG
########
database_name=$1
file_name=$2

TASK_NAME="Dumping database $database_name to file $file_name"


# PROGRAM
#########

work-start "$TASK_NAME"

if [ $# -ne 2 ]
then
    print-error "Must be 2 parameters."
    print-info "Example: database_to_file.sh forge /tmp/everning.sql"
    exit 1
elif [ -f $file_name ]  # if file exist --> rewrite y/n ?
then
    print-warning "File $file_name already exists."
    print-warning "Overwrite it (y/n) ?"
    read answer
    if [ "$answer" != y ]
    then
        exit 2
    fi
fi

print-command "mysqldump $database_name > $file_name"
mysqldump $database_name > $file_name

work-end-summary "$TASK_NAME"


# TODO
######

# WAREHOUSE
###########
