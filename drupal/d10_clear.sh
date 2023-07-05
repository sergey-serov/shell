#!/bin/bash
set -x
rm -fr /var/www/experiment1/www/sites/default/files/php/twig/*

mysql -e "
use experiment1;
truncate table cache_bootstrap;
truncate table cache_config;
truncate table cache_container;
truncate table cache_data;
truncate table cache_default;
truncate table cache_discovery;
truncate table cache_discovery_migration;
truncate table cache_entity;
truncate table cache_jsonapi_normalizations;
truncate table cache_menu;
truncate table cache_migrate;
truncate table cache_render;
truncate table cache_rest;
truncate table cache_toolbar;
"

set +x
