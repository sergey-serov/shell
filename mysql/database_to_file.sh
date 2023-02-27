#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Dump MySQL database to file.


# HELP
######

# $1 = Database name

# Example: 


# CONFIG
########
database_name=$1

TASK_NAME="Dumping database $database_name to file"


# PROGRAM
#########

work-start "$TASK_NAME"

# print-command "mysqldump $database_name > $database_name.sql"

mysqldump $database_name > $database_name.sql

work-end-summary "$TASK_NAME"


# TODO
######

# WAREHOUSE
###########
