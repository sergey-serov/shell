#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Display notification.
# `crontab -e`


# HELP
######

# $1 - type of notification: pause | tea/coffe/eat | bike



# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh

RANDOM_IMAGE=`shuf -n1 -e /home/sergey/Pictures/Wallpapers/*.jpg`
TYPE_OF_NOTIFICATION=$1

# PROGRAM
#########

if [[ "$TYPE_OF_NOTIFICATION" == "pause" ]]; then
  notify-send -i $RANDOM_IMAGE 'Встать и пройти по комнате!' 'Размять руки, ноги. Зарядка для глаз.'
fi

if [[ "$TYPE_OF_NOTIFICATION" == "tea/coffe/eat" ]]; then
  notify-send -i $RANDOM_IMAGE 'Чай, кофе или еда!' 'Пойти на кухню и дать организму питательные вещества.'
fi

if [[ "$TYPE_OF_NOTIFICATION" == "bike" ]]; then
  notify-send -i $RANDOM_IMAGE 'Разминка!' 'Велотренажёр или зарядка. 15 и более минут.'
fi
