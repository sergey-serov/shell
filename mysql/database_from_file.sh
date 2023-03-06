#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Restore MySQL database from file.
# Attention! Database will be droped and created before restoring.


# HELP
######

# $1 = Database name
# $2 = File name

# Exit codes:
# 1 - not correct number of parameters
# 2 - file not exist

# Example: ./database_from_file.sh forge /tmp/morning.sql

# CONFIG
########
database_name=$1
file_name=$2

TASK_NAME="Restoring data from file $file_name to database $database_name"


# PROGRAM
#########

work-start "$TASK_NAME"

if [ $# -ne 2 ]
then
    print-error "Must be 2 parameters."
    print-info "Example: database_from_file.sh forge /tmp/morning.sql"
    exit 1
elif [ ! -f $file_name ]
then
    print-error "File $file_name not exists"
    exit 2
fi

set -x
echo "
DROP DATABASE $database_name;
CREATE DATABASE $database_name;
" | mysql
set +x

print-command "mysql $database_name < $file_name"
mysql $database_name < $file_name

work-end-summary "$TASK_NAME"


# TODO
######

# WAREHOUSE
###########
