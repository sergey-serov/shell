#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Create new virtual host and restart httpd


# HELP
######

# $1 = virtual host short name, without suffix .local
# Example: forge1


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

VIRTUAL_HOST_SHORT_NAME=$1
VIRTUAL_HOST_FULL_NAME="$VIRTUAL_HOST_SHORT_NAME.local"
VIRTUAL_HOST_PATH=$HOME_WWW/$VIRTUAL_HOST_FULL_NAME


# PROGRAM
#########
$HOME_SCRIPT_SERVICES/work-start.sh "Creating new local virtual host '$VIRTUAL_HOST_FULL_NAME'"

$ECHO_COMMAND "mkdir $VIRTUAL_HOST_PATH"
mkdir $VIRTUAL_HOST_PATH

$ECHO_COMMAND "mkdir $VIRTUAL_HOST_PATH/tmp $VIRTUAL_HOST_PATH/sessions $VIRTUAL_HOST_PATH/logs $VIRTUAL_HOST_PATH/www"
mkdir $VIRTUAL_HOST_PATH/tmp $VIRTUAL_HOST_PATH/sessions $VIRTUAL_HOST_PATH/logs $VIRTUAL_HOST_PATH/www

$ECHO_COMMAND "chmod 777 $VIRTUAL_HOST_PATH/tmp $VIRTUAL_HOST_PATH/sessions $VIRTUAL_HOST_PATH/logs"
chmod 777 $VIRTUAL_HOST_PATH/tmp $VIRTUAL_HOST_PATH/sessions $VIRTUAL_HOST_PATH/logs

$ECHO_COMMAND "chown -R sergey:sergey $VIRTUAL_HOST_PATH/"
chown -R sergey:sergey $VIRTUAL_HOST_PATH/

$ECHO_COMMAND "chown -R apache:apache $VIRTUAL_HOST_PATH/sessions/ $VIRTUAL_HOST_PATH/logs/ $VIRTUAL_HOST_PATH/tmp/"
chown -R apache:apache $VIRTUAL_HOST_PATH/sessions/ $VIRTUAL_HOST_PATH/logs/ $VIRTUAL_HOST_PATH/tmp/


$ECHO_COMMAND "Create new config - $VIRTUAL_HOST_SHORT_NAME.conf"
echo "<VirtualHost *:80>

  DocumentRoot $VIRTUAL_HOST_PATH/www

  ServerName $VIRTUAL_HOST_FULL_NAME
  ServerAlias www.$VIRTUAL_HOST_FULL_NAME

  ErrorLog $VIRTUAL_HOST_PATH/logs/apache_error.log

  <Directory $VIRTUAL_HOST_PATH/www>
    Options -Indexes
    AllowOverride All
    Require all granted
  </Directory>

  php_admin_value upload_tmp_dir $VIRTUAL_HOST_PATH/tmp
  php_admin_value error_log $VIRTUAL_HOST_PATH/logs/php.log
  php_admin_value session.save_path $VIRTUAL_HOST_PATH/sessions

</VirtualHost>" > /etc/httpd/conf.d/$VIRTUAL_HOST_SHORT_NAME.conf

$ECHO_COMMAND "echo \"127.0.0.1 $VIRTUAL_HOST_FULL_NAME www.$VIRTUAL_HOST_FULL_NAME\" >> /etc/hosts"
echo "127.0.0.1 $VIRTUAL_HOST_FULL_NAME www.$VIRTUAL_HOST_FULL_NAME" >> /etc/hosts

$ECHO_COMMAND "service httpd restart"
service httpd restart

$HOME_SCRIPT_SERVICES/work-end-summary.sh "Creating new local virtual host '$VIRTUAL_HOST_FULL_NAME'"
$HOME_SCRIPT_SERVICES/work-end-sound.sh