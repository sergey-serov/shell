#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Correct right owner, permissions and Selinux context for drupal site


# HELP
######

# $1 = full site name
# example: sergey-serov.ru


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh

SITE_NAME=$1
SITE_PATH="$HOME_WWW/$SITE_NAME"


# PROGRAM
#########

# remove
# rm -f install.php update.php xmlrpc.php CHANGELOG.txt COPYRIGHT.txt INSTALL.mysql.txt INSTALL.pgsql.txt INSTALL.sqlite.txt INSTALL.txt LICENSE.txt MAINTAINERS.txt README.txt UPGRADE.txt
# rm -rf profiles/ scripts/

# Remove 'i' attribute
run_command "chattr -R -i $SITE_PATH/www"

# chown
run_command "chown -R apache:apache $SITE_PATH/www"

# chmod
$ECHO_COMMAND "find $SITE_PATH/www -type f -exec chmod 444 {} \;"
find $SITE_PATH/www -type f -exec chmod 444 {} \;

$ECHO_COMMAND "find $SITE_PATH/www -type d -exec chmod 555 {} \;"
find $SITE_PATH/www -type d -exec chmod 555 {} \;

$ECHO_COMMAND "find $SITE_PATH/www/sites/default/files -type f -exec chmod 644 {} \;"
find $SITE_PATH/www/sites/default/files -type f -exec chmod 644 {} \;

$ECHO_COMMAND "find $SITE_PATH/www/sites/default/files -type d -exec chmod 755 {} \;"
find $SITE_PATH/www/sites/default/files -type d -exec chmod 755 {} \;

# selinux
# delete before check
$ECHO_COMMAND "semanage fcontext -a -t httpd_sys_script_exec_t \"$SITE_PATH/www(/.*)?\""
semanage fcontext -a -t httpd_sys_script_exec_t "$SITE_PATH/www(/.*)?"

$ECHO_COMMAND "semanage fcontext -a -t public_content_rw_t \"$SITE_PATH/www/sites/default/files(/.*)?\""
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/www/sites/default/files(/.*)?"

run_command "restorecon -R -v $SITE_PATH"
