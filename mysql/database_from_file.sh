#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Restore MySQL database from file.
# Attention! Database will be droped and created before restoring.


# HELP
######

# $1 = Database name

# Example: 


# CONFIG
########
database_name=$1

TASK_NAME="Restoring data from file to database $database_name"


# PROGRAM
#########

work-start "$TASK_NAME"

set -x
echo "
DROP DATABASE $database_name;
CREATE DATABASE $database_name;
" | mysql
set +x

print-command "mysql $database_name < $database_name.sql"
mysql $database_name < $database_name.sql

work-end-summary "$TASK_NAME"


# TODO
######

# WAREHOUSE
###########
