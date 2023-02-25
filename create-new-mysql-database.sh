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
set -x
database_name=$1
database_user=$2
database_user_password=$3

TASK_NAME="Creating new local mysql database"

# PROGRAM
#########

work-start "$TASK_NAME"

query_1=`/usr/bin/mysql -u$MYSQL_ADMIN -p$MYSQL_PASSWORD<<SQL
CREATE DATABASE $database_name;
CREATE USER "$database_user"@"localhost" IDENTIFIED BY "$database_user_password";
GRANT ALL PRIVILEGES ON $database_name.* TO "$database_user"@"localhost";
FLUSH PRIVILEGES;
quit
SQL`




# If SQL error - this string will be not empty
if [ -n "$query_1" ]
then
    print-error $query_1
else
    print-info "Database '$database_name' was created for user '$database_user' with password '$database_user_password'"
fi

print-info "Now MySQL have these databases:"

query_2=`/usr/bin/mysql -u$MYSQL_ADMIN -p$MYSQL_PASSWORD<<SQL
SHOW DATABASES;
quit
SQL`

if [ -n "$query_2" ]
then
    print-info $query_2
else
    print-error 'Can not get database list.'
fi

work-end-summary "$TASK_NAME"


# TODO
######

# WAREHOUSE
###########
set +x

# CREATE USER 'username'@'host' IDENTIFIED WITH authentication_plugin BY 'password';
