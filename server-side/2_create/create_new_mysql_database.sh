#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Create new MySQL database


# HELP
######

# $1 = database name
# $2 = имя пользователя, которому будет доступна эта новая база данных и все таблицы в ней
# $3 = пароль, для этого пользователя
# Например: ./create_new_mysql_database.sh test_db test_user test_password


# CONFIG
########

. /root/1_warehouse/5_script_services/useful_variables.sh

DATABASE_NAME=$1
DATABASE_USER=$2
DATABASE_USER_PASSWORD=$3


# PROGRAM
#########

$HOME_SCRIPT_SERVICES/work-start.sh "Creating new local mysql database"

QUERY=`/usr/bin/mysql -uroot -pPASSWORD<<SQL
CREATE DATABASE $DATABASE_NAME;
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO "$DATABASE_USER"@"localhost" IDENTIFIED BY "$DATABASE_USER_PASSWORD";
quit
SQL`

# If error -this string will be not empty
echo $QUERY

echo "Database '$DATABASE_NAME' was created for user '$DATABASE_USER' with password '$DATABASE_USER_PASSWORD'"
echo "Now MySQL have follows databases:"

QUERY=`/usr/bin/mysql -uroot -pPASSWORD<<SQL
SHOW DATABASES;
quit
SQL`

echo $QUERY

$HOME_SCRIPT_SERVICES/work-end-summary.sh "Creating new local mysql database"
