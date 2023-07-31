#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Create new virtual host on local workstation.
# Create directories, configs etc and restart Apache.


# HELP
######

# $1 = virtual host name
# Example: forge


# CONFIG
########
# set -x
name=$1

web_root='/var/www'
path="$web_root/$name"

TASK_NAME="Creating new local virtual host '$name'"


# PROGRAM
#########

work-start "$TASK_NAME"

if [ $# -ne 1 -o -z "$1" ]
then
    print-error "Must be 1 parameter - virtual host name."
    print-info "Usage: ./create-new-virtual-host.sh forge"
    print-warning "Exit..."
    exit 1
elif [ -d $path ]
then
    print-error "Directory for virtual host already exists!"
    print-warning "Exit..."
    exit 2
fi

run-command "sudo mkdir $path"

run-command "sudo mkdir -m=755 $path/logs"
run-command "sudo mkdir -m=755 $path/sessions"
run-command "sudo mkdir -m=755 $path/tmp"
run-command "sudo mkdir -m=755 $path/www"

run-command "sudo chown -v www-data:www-data $path/logs"
run-command "sudo chown -v www-data:www-data $path/sessions"
run-command "sudo chown -v www-data:www-data $path/tmp"
run-command "sudo chown -v sergey:sergey $path/www"

print-info "Create new Apache config - /etc/apache2/sites-available/$name.conf"

echo "<VirtualHost *:80>

  DocumentRoot $path/www

  ServerName $name
  ServerAlias www.$name

  ErrorLog $path/logs/apache_error.log

  <Directory $path/www>
    Options -Indexes
    AllowOverride All
    Require all granted
  </Directory>

  php_admin_value open_basedir $path/www:$path/tmp
  php_admin_value doc_root $path/www
  php_admin_value upload_tmp_dir $path/tmp
  php_admin_value error_log $path/logs/php.log
  php_admin_value session.save_path $path/sessions

</VirtualHost>" | sudo tee /etc/apache2/sites-available/$name.conf

print-command "echo \"127.0.0.1 $name www.$name\" | sudo tee --append /etc/hosts"

echo "127.0.0.1 $name www.$name" | sudo tee --append /etc/hosts

run-command "sudo a2ensite $name.conf"
run-command "sudo service apache2 restart"

work-end-summary "$TASK_NAME"

# TODO
######

# check that two arguments were passed here. + permissions!
# output table: all current virtual host + /etc/hosts
# + Apache available/enabled sites
# + du

# WAREHOUSE
###########

# fc -s tmp=sessions mkdir # works!
set +x