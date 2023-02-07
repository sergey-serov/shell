#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Create new virtual host on local workstation.
# Create directories, configs etc and restart Apache.


# HELP
######

# $1 = virtual host name
# Example: forge1.local

# $2 = path to host root directory, must be created before.
# Example: /var/www/forge1.local


# CONFIG
########

virtual_host_name=$1
virtual_host_path=$2

TASK_NAME="Creating new local virtual host '$virtual_host_name'"


# PROGRAM
#########

work-start "$TASK_NAME"

run-command "sudo mkdir $virtual_host_path/tmp $virtual_host_path/sessions $virtual_host_path/logs $virtual_host_path/www"
run-command "sudo chmod 755 $virtual_host_path/tmp $virtual_host_path/sessions $virtual_host_path/logs"
run-command "sudo chown -R sergey:sergey $virtual_host_path/www"
run-command "sudo chown -R www-data:www-data $virtual_host_path/sessions $virtual_host_path/logs $virtual_host_path/tmp"

print-action "Create new Apache config - /etc/apache2/sites-available/$virtual_host_name.conf"

echo "<VirtualHost *:80>

  DocumentRoot $virtual_host_path/www

  ServerName $virtual_host_name
  ServerAlias www.$virtual_host_name

  ErrorLog $virtual_host_path/logs/apache_error.log

  <Directory $virtual_host_path/www>
    Options -Indexes
    AllowOverride All
    Require all granted
  </Directory>

  php_admin_value open_basedir $virtual_host_path/www:$virtual_host_path/tmp
  php_admin_value doc_root $virtual_host_path/www
  php_admin_value upload_tmp_dir $virtual_host_path/tmp
  php_admin_value error_log $virtual_host_path/logs/php.log
  php_admin_value session.save_path $virtual_host_path/sessions

</VirtualHost>" | sudo tee /etc/apache2/sites-available/$virtual_host_name.conf

print-action "echo \"127.0.0.1 $virtual_host_name www.$virtual_host_name\" | sudo tee --append /etc/hosts"

echo "127.0.0.1 $virtual_host_name www.$virtual_host_name" | sudo tee --append /etc/hosts

run-command "cd /etc/apache2/sites-available"
run-command "sudo a2ensite $virtual_host_name.conf"
run-command "sudo service apache2 restart"

work-end-summary "$TASK_NAME"

# TODO
######

# check that two arguments were passed here. + permissions!

# WAREHOUSE
###########
