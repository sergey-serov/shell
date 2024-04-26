#! /bin/bash

# author: Sergey Serov

# DESCRIPTION
#############
# Some actions when start and auto login workstation


# HELP
######


# CONFIG
########
. /home/sergey/forge-home/1_shell_scripts/script_services/useful_variables.sh


# PROGRAM
#########


# use 'xev' for define Keycode and Keysym
# xmodmap -e "keycode 10 = exclam"
# xmodmap -e "keycode 11 = at"
# xmodmap -e "keycode 12 = numbersign"
# xmodmap -e "keycode 13 = dollar"
# xmodmap -e "keycode 14 = percent"
# xmodmap -e "keycode 17 = asterisk"
# xmodmap -e "keycode 18 = parenleft"
# xmodmap -e "keycode 19 = parenright"

xmodmap -e "keycode 82 = underscore"

# play "`shuf -n1 -e /home/sergey/Music/Hearthstone_Soundtrack/*.ogg`"
