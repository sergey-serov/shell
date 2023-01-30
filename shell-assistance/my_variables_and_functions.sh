##
# Aliases
#

alias df='df -h'
alias du='du -sh'

alias l='ls --group-directories-first -Fv'
alias ll='ls --group-directories-first --human-readable -alFv'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# colors for pretty output
# http://misc.flogisoft.com/bash/tip_colors_and_formatting
COLOR_END='\e[0m'

# Text colors
BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
LIGHT_GREEN='\e[92m'
YELLOW='\e[0;33m'
NAVY='\e[0;34m'
BLUE='\e[34m'
LIGHT_BLUE='\e[94m'
PURPLE='\e[0;35m'
MAGENTA='\e[35m'
LIGHT_MAGENTA='\e[95m'
TURQUOISE='\e[0;36m'
WHITE='\e[0;37m'
LIGHT_GRAY='\e[37m'
DARK_GRAY='\e[90m'
### echo -e "\e[38;5;82mHello \e[38;5;198mWorld"

# Text format
BOLD='\e[1m'
UNDERLINED='\e[4m'
BLINK='\e[5m'

# Background colors. REMEMBER: first must be text color, then background color.
MAGENTA_BG='\e[45m'
PURPLE_BG='\e[45m'


##
# Horizont line for PS1
#

horisont_1 () {  

    HORIZONT_1=
    local CONSOLE_WIDTH=$(($COLUMNS)) # place for time

    # create line
    while [ $CONSOLE_WIDTH -gt 0 ]
    do
        HORIZONT_1="${HORIZONT_1}―" # Unicode U+2015 "Horisontal bar"
        CONSOLE_WIDTH=$(($CONSOLE_WIDTH-1))
    done

    # add time at the end
    HORIZONT_1="${HORIZONT_1}" #  [\t]

    # final
    echo -en $HORIZONT_1
}

##
# Horizont line for PS0
#
horisont_2 () {

    HORIZONT_2=

    local DATE_PATTERN="%A | %d %B | %Y | %T | week %U"
    local DATE_SYMBOLS=$(printf "%(${DATE_PATTERN})T" -1 | wc -m)
    local CONSOLE_WIDTH=$(($COLUMNS-$DATE_SYMBOLS-15)) # place for time, date and command number

    # create line
    while [ $CONSOLE_WIDTH -gt 0 ]
    do
        HORIZONT_2="${HORIZONT_2}-" # Unicode U+2015 "Horisontal bar"
        CONSOLE_WIDTH=$(($CONSOLE_WIDTH-1))
    done

    # add time at the end
    HORIZONT_2="${HORIZONT_2} \D{"${DATE_PATTERN}"} | command \#"

    # final
    echo -en $HORIZONT_2
}

##
# Repository info for PS1
#

repo_info () {

    IS_REPO=
    REPO_INFO=
    REPO_DESCRIPTION=

    # branch
    IS_REPO=$(__git_ps1)
    if [ -n "$IS_REPO" ]
    then 
        REPO_INFO=$BLUE$IS_REPO$COLOR_END
    fi

    # repo description
    if [[ -d .git && -f .git/description ]]
    then
        local REPO_DESCRIPTION=$(cat .git/description)
    fi
  
    if echo "$REPO_DESCRIPTION" | grep "Unnamed repository" > /dev/null
    then
        REPO_DESCRIPTION="${YELLOW} no description... ${COLOR_END}"
    else
        REPO_DESCRIPTION="${TURQUOISE} ${REPO_DESCRIPTION} ${COLOR_END}"
    fi

    # final
    REPO_INFO="${REPO_INFO} ${REPO_DESCRIPTION}"

    echo -en $REPO_INFO
}


##
# Init my variables for PS*
#

init_prompt_variables () {
    horisont_1
    horisont_2
}


##
# Is success or fail in previous command ?
#

print_previos_command_result () {

    if [ "$?" -eq 0 ]
    then
        PREVIOUS_COMMAND_RESULT="completed"
    else
        PREVIOUS_COMMAND_RESULT="${GREEN}finished with error${COLOR_END}"
    fi

    echo -e $PREVIOUS_COMMAND_RESULT
}

##
# Set timer when command was run
# @todo delete when exit from shell

set_timer () {
    local START=$(date +%s)
    echo -n $START > /tmp/console_command_timer
}

##
# Print current timer value
#

print_timer_result () {
    local START=$(cat /tmp/console_command_timer)
    local END=$(date +%s)

    TIMER_RESULT=$(($END-$START))
    echo -e $TIMER_RESULT
}

##
# Run before every prompt
#
# set +x
# init_prompt_variables
# PROMPT_COMMAND=init_prompt_variables
# set -x

##
# PS1
#

USER_AND_HOST="[${YELLOW}\u${COLOR_END}${BLUE}@${COLOR_END}${TURQUOISE}\h${COLOR_END}]"
CURRENT_DIR="${DARK_GRAY}\$(pwd)${COLOR_END}"


PS1="${PURPLE}--- \$(print_previos_command_result) at \$(print_timer_result) seconds. ${COLOR_END}\n${GREEN}\$(horisont_1)${COLOR_END}\n${USER_AND_HOST} ${CURRENT_DIR} \$(repo_info)\n🌌 "


##
# PS0
#

PS0="${PURPLE}\$(horisont_2)${COLOR_END}\n\$(set_timer)"


# PS1="${GREEN}[\u@\h] \$(pwd) ============================================ [\t]${COLOR_END}\n🌌 "
# output example:
# [sergey@castle]  /home/sergey/Forge/shell ============================================ [15:30:23]
# 🌌 

##
# TODO
#

# Рефакторинг после прочтения книги.

# debian_chroot
# iptables local :))))
# statistics for apps which uses network!
# top, df - welcome message

##
# Warehouse
#

# PS1="$HORIZONT
# # time: \t
# # user: \u
# # host: \H
# # path: \w
# # repo: $REPO_INFO
# > "
# 💐🌳


    #  add green or red color TODO in cvs status

update () {
    sudo apt update && sudo apt upgrade
}