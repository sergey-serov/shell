#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# Mail to me list of all new files and files which were deleted


# HELP
######


# CONFIG
########
. /root/1_warehouse/5_script_services/useful_variables.sh

NEW_LIST=$HOME_SHELL_SCRIPTS/8_defence/new_list
CANONICAL_LIST=$HOME_SHELL_SCRIPTS/8_defence/canonical_list
DIFF_LIST=$HOME_SHELL_SCRIPTS/8_defence/diff_list


# PROGRAM
#########

cd /var/www/html
find . > $NEW_LIST
diff $CANONICAL_LIST $NEW_LIST >> $DIFF_LIST
rm $CANONICAL_LIST
mv $NEW_LIST $CANONICAL_LIST
