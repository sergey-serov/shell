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

# chown
chown root:root $SITE_PATH/logs
chown apache:apache $SITE_PATH/www
chown apache:apache $SITE_PATH/sessions
chown apache:apache $SITE_PATH/tmp

chown apache:apache $SITE_PATH/logs/apache_access.log
chown apache:apache $SITE_PATH/logs/apache_error.log
chown apache:apache $SITE_PATH/logs/php.log

chown nginx:nginx $SITE_PATH/logs/nginx_access.log
chown nginx:nginx $SITE_PATH/logs/nginx_error.log
chown nginx:nginx $SITE_PATH/logs/nginx_deny.log


# chmod
chmod 555 $SITE_PATH
chmod 555 $SITE_PATH/www
chmod 555 $SITE_PATH/logs
chmod 700 $SITE_PATH/sessions
chmod 700 $SITE_PATH/tmp

chmod 600 $SITE_PATH/logs/apache_access.log
chmod 600 $SITE_PATH/logs/apache_error.log
chmod 600 $SITE_PATH/logs/php.log
chmod 600 $SITE_PATH/logs/nginx_access.log
chmod 600 $SITE_PATH/logs/nginx_error.log
chmod 600 $SITE_PATH/logs/nginx_deny.log


# Selinux context
# add context
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/logs/apache_access.log"
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/logs/apache_error.log"
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/logs/php.log"
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/logs/nginx_access.log"
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/logs/nginx_error.log"
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/logs/nginx_deny.log"

semanage fcontext -a -t httpd_sys_script_exec_t "$SITE_PATH/www(/.*)?"
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/sessions(/.*)?"
semanage fcontext -a -t public_content_rw_t "$SITE_PATH/tmp(/.*)?"

# reset contexts
restorecon -R -v $SITE_PATH
