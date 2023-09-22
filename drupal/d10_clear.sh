#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Clear Drupal 10 all caches.
# This script maps to hot keys and runs in background.
# Result outputs in log.

# HELP
######

# CONFIG
########
LOG='/tmp/drupal10_clear.log'

# PROGRAM
#########

curl -I "http://$CURRENTLY_SITE/core/rebuild.php" >> $LOG

curl -s "http://$CURRENTLY_SITE/core/rebuild.php"


# TODO
######
# NOT TESTED!
# add lock switcher
# add key!

# WAREHOUSE
###########

# if [[  ]]
# then
#     echo 'Cache was cleared.' >> /tmp/drupal10_clear.log
# fi

# curl -I "http://$CURRENTLY_SITE/core/rebuild.php" >> /tmp/drupal10_clear.log

# set -x
# rm -fr /var/www/$CURRENTLY_SITE/www/sites/default/files/php/twig/*

# mysql -e "
# use $CURRENTLY_DATABASE;
# truncate table cache_bootstrap;
# truncate table cache_config;
# truncate table cache_container;
# truncate table cache_data;
# truncate table cache_default;
# truncate table cache_discovery;
# truncate table cache_discovery_migration;
# truncate table cache_entity;
# truncate table cache_jsonapi_normalizations;
# truncate table cache_menu;
# truncate table cache_migrate;
# truncate table cache_render;
# truncate table cache_rest;
# truncate table cache_toolbar;
# "

# set +x
