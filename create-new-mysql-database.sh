#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Create new MySQL database

# HELP
######

# $1 = database name
# $2 = user name with access to all tables here
# $3 = password

# Example: ./create-new-mysql-database.sh forge blacksmith MightAndIron123

# CONFIG
########
database_name=$1
database_user=$2
database_user_password=$3

TASK_NAME="Creating new local mysql database"

# PROGRAM
#########

work-start "$TASK_NAME"

# Create database and user
print-info "Trying to create database and user..."

set -x
echo "
CREATE DATABASE $database_name;
CREATE USER '$database_user'@'localhost' IDENTIFIED BY '$database_user_password';
GRANT ALL PRIVILEGES ON $database_name.* TO '$database_user'@'localhost';
FLUSH PRIVILEGES;" | mysql -t
set +x

# Check that database was created
print-info "Trying to find just created new database..."

# this is retro style for sql query from bash
query=`/usr/bin/mysql<<SQL
SHOW DATABASES LIKE "$database_name";
quit
SQL`

if [ -n "$query" ]
then
    print-info "Database '$database_name' exists."
fi

# Get list of all databases
print-info "Trying to get list of all databases..."

mysql -e "SHOW DATABASES;"

work-end-summary "$TASK_NAME"


# TODO
######

# WAREHOUSE
###########

# CREATE USER 'username'@'host' IDENTIFIED WITH authentication_plugin BY 'password';
