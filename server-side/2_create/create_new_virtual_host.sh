#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Create new virtual host


# HELP
######

# $1 = site name WITH suffix
# Example: sergey-serov.ru


# CONFIG
########

. /root/1_warehouse/5_script_services/useful_variables.sh

SITE_NAME=$1
SITE_PATH="$HOME_WWW/$SITE_NAME"


# PROGRAM
#########

# create directories
mkdir $SITE_PATH
mkdir $SITE_PATH/www 
mkdir $SITE_PATH/logs 
mkdir $SITE_PATH/sessions 
mkdir $SITE_PATH/tmp


# create logs
touch $SITE_PATH/logs/apache_access.log
touch $SITE_PATH/logs/apache_error.log
touch $SITE_PATH/logs/php.log
touch $SITE_PATH/logs/nginx_access.log
touch $SITE_PATH/logs/nginx_error.log
touch $SITE_PATH/logs/nginx_deny.log


$HOME_SHELL_SCRIPTS/3_update_site/correct-structure-attributes.sh $SITE_NAME


# Create nginx config

host='$host'
remote_addr='$remote_addr'
uri='$uri'
document_root='$document_root'
scheme='$scheme'

echo "# Riverside Fortress security configuration
# One site nginx config

server {
  server_name $SITE_NAME;
  return 301 $scheme://www.$SITE_NAME$request_uri;
}

server {

  listen 80;
  server_name www.$SITE_NAME;
  root $SITE_PATH/www;
  access_log $SITE_PATH/logs/nginx_access.log;
  error_log $SITE_PATH/logs/nginx_error.log;

  # maintenance
  #############
  
  if (-f $document_root/maintenance.html) {
    return 503;
  }
  error_page 503 @maintenance;
  location @maintenance {
      rewrite ^(.*)$ /maintenance.html break;
  }

  # security
  ##########

  location ~ (^|/)\. {
    access_log $SITE_PATH/logs/nginx_deny.log;
    deny all;
  }

  location ~ (^|/)~ {
    access_log $SITE_PATH/logs/nginx_deny.log;
    deny all;
  }

  location ~ ~$ {
    access_log $SITE_PATH/logs/nginx_deny.log;
    deny all;
  }

  location ~ \.php$ {
    access_log $SITE_PATH/logs/nginx_deny.log;
    deny all;
  }

  # proxy to httpd
  ################

  location =/index.php {
    proxy_pass http://127.0.0.1:8033;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
  }

  location =/cron.php {
    proxy_pass http://127.0.0.1:8033;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
  }

  location / {
    proxy_pass http://127.0.0.1:8033;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
  }

  # drupal image styles
  #####################

  location ~* /sites/default/files/styles/ {
    try_files $uri @imagestyles;
  }

  location @imagestyles {
    proxy_pass http://127.0.0.1:8033;
    proxy_set_header Host $host;
    access_log off;
  }

  # static files (may be place it after drupal styles)
  ##############

  location ~* \.(html|jpg|jpeg|gif|png|ico|css|js|pdf|tar|tgz|gz|zip|rar|ogg|mp3|flv|doc|xls|txt)$ {
    expires 30d;
    access_log off;
  }

  # some services
  ###############

  # firewall
  ##########

}

# end configuration
" > /etc/nginx/conf.d/$SITE_NAME.conf

# Create apache config
echo "# Riverside Fortress security configuration
# One site httpd config

<VirtualHost *:8033>

  DocumentRoot $SITE_PATH/www

  ServerName $SITE_NAME
  ServerAlias www.$SITE_NAME

  ErrorLog $SITE_PATH/logs/apache_error.log
  CustomLog $SITE_PATH/logs/apache_access.log combined

  <Directory $SITE_PATH/www>
    Options -Indexes
    AllowOverride All
    Order allow,deny
    Allow from all
  </Directory>

  php_admin_value open_basedir $SITE_PATH/www:$SITE_PATH/tmp
  php_admin_value doc_root $SITE_PATH/www
  php_admin_value upload_tmp_dir $SITE_PATH/tmp
  php_admin_value error_log $SITE_PATH/logs/php.log
  php_admin_value session.save_path $SITE_PATH/sessions

</VirtualHost>
" > /etc/httpd/conf.d/$SITE_NAME.conf

# Create maintenance page
echo '<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Maintenance</title>
  <style type="text/css">
    body {
      background-color: #cbe3fb;
      margin: 0;
      padding: 0;
    }
    .message-block {
      width: 500px;
      margin: 100px auto;
      border: solid 4px #eeeb18;
      background-color: white;
      padding: 30px 40px;
    }
    .message {
      font-size: 18px;
      color: #333;
    }
    .decoration-line {
      font-size: 26px;
      color: #1881E7;
      text-align: center;
      padding: 20px 0;
    }
    .footer {
      height: 120px;
      width: 100%;
      background-color: #26a91f;
      position: absolute;
      bottom: 0;
      border-bottom: solid 30px #50380a;
    }
  </style>
</head>
<body>
  <div class="message-block">
    <div class="message">Сайт временно не доступен по техническим причинам. Скорее всего он заработает через 10 минут.</div>
    <div class="decoration-line">* * *</div>
    <div class="message">Site not working now by technical reasons. As usually it will be online again through 10 minutes.</div>
  </div>
  <div class="footer"></div>
</body>
</html>' > $SITE_PATH/maintenance.html
