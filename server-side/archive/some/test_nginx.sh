#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Automate check nginx config


# HELP
######

# $1 = site url


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

SITE_URL=$1


# PROGRAM
#########

echo '--------------------------------------------------------------------------'
echo "test $SITE_URL nginx configuration"
echo '--------------------------------------------------------------------------'

# check different urls
######################

# $1 = path
# $2 = what we expect
function check_address() {
	RESULT=$(curl -Is "$SITE_URL$1" | head -n1 | cut -d ' ' -f2)
	echo "$1"
	echo "we expect: $2"
	echo "we recive: $RESULT"

	if [[ $RESULT = $2 ]]; then
		echo -e "$GREEN ok $COLOR_END"
	fi

	if [[ $RESULT != $2 ]]; then
		echo -e "$RED false $COLOR_END"
	fi

	echo "response headers:"
	curl -Is "$SITE_URL$1"

	echo '---------------------'
}

check_address '/' 200
check_address '/index.html' 200
check_address '/index.php' 200
check_address '/must-redirect.php' 301
check_address '/no-such-php-file-and-it-must-redirected-too.php' 301
check_address '/.must-be-denyed.php' 403
check_address '/no-such-static-file.txt' 404

# what in logs
##############
echo '--------------------'
echo '/var/log/nginx/error.log'
echo '--------------------'
tail /var/log/nginx/error.log

echo '--------------------'
echo '/var/www/html/site_name/logs/nginx_error.log'
echo '--------------------'
tail /var/www/html/site_name/logs/nginx_error.log

echo '--------------------'
echo '/var/www/html/site_name/logs/nginx_access.log'
echo '--------------------'
tail /var/www/html/site_name/logs/nginx_access.log
