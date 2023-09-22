echo Hello World!

##
# Starts personal environment :)
#

#
# Load files with passwords, ports etc which are not goes into repo or anywere else.
#
if [ -f $HOME/server_private_variables.sh ]
then
    chmod 600 $HOME/server_private_variables.sh
    . $HOME/server_private_variables.sh
else
    echo File server_private_variables.sh not exists or accesseble for reading.
fi

##
# Aliases
#

alias df='df -h'
alias du='du -sh'

alias l='ls --group-directories-first -Fv'
alias ll='ls --group-directories-first --human-readable -alFv'

alias cp='cp -i'

##
# Rewrite standard settings
#

HISTFILESIZE=all

##
# Colors and text format
#

# colors for pretty output
# http://misc.flogisoft.com/bash/tip_colors_and_formatting
export COLOR_END='\e[0m'

# Text colors
export BLACK='\e[0;30m'
export RED='\e[0;31m'
export GREEN='\e[0;32m'
export LIGHT_GREEN='\e[92m'
export YELLOW='\e[0;33m'
export NAVY='\e[0;34m'
export BLUE='\e[34m'
export LIGHT_BLUE='\e[94m'
export PURPLE='\e[0;35m'
export MAGENTA='\e[35m'
export LIGHT_MAGENTA='\e[95m'
export TURQUOISE='\e[0;36m'
export WHITE='\e[0;37m'
export LIGHT_GRAY='\e[37m'
export DARK_GRAY='\e[90m'
### echo -e "\e[38;5;82mHello \e[38;5;198mWorld"

# Background colors. ATTENSION: first must be text color,
# then background color or text format.
export MAGENTA_BG='\e[45m'
export PURPLE_BG='\e[45m'

# Text format
export BOLD='\e[1m'
export UNDERLINED='\e[4m'
export BLINK='\e[5m'

update () {
    run-command "sudo apt update"
    run-command "sudo apt upgrade"
}

ws () {
    run-command "sudo service nginx start"
    run-command "sudo service apache2 start"
    run-command "sudo service mysql start"
}

wi () { # todo: add parametr v for full output and by deafult short status message.
    run-command "sudo service nginx status"
    run-command "sudo service apache2 status"
    run-command "sudo service mysql status"
}

wf () {
    run-command "sudo service nginx stop"
    run-command "sudo service apache2 stop"
    run-command "sudo service mysql stop"
}

