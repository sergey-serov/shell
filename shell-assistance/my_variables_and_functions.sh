##
# Alias
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
TURQUOISE='\e[0;36m'
WHITE='\e[0;37m'
LIGHT_GRAY='\e[37m'
DARK_GRAY='\e[90m'
###echo -e "\e[38;5;82mHello \e[38;5;198mWorld"

# Text format
BOLD='\e[1m'
UNDERLINED='\e[4m'
BLINK='\e[5m'

# Background colors. REMEMBER: first must be text color, then background color.
MAGENTA_BG='\e[45m'
PURPLE_BG='\e[45m'


##
# Horizont line for PS0 and PS1
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
}

horisont_2 () {

    HORIZONT_2=

    local DATE_PATTERN="%A | %d %B | %Y | %T | week %U"
    # echo 'debug 1: ' $DATE_PATTERN
    local DATE_SYMBOLS=$(printf "%(${DATE_PATTERN})T" -1 | wc -m)
    # echo 'debug 2: ' $DATE_SYMBOLS
    local CONSOLE_WIDTH=$(($COLUMNS-$DATE_SYMBOLS-15)) # place for time, date and command number
    # echo 'debug 3: ' $CONSOLE_WIDTH

    # create line
    while [ $CONSOLE_WIDTH -gt 0 ]
    do
        HORIZONT_2="${HORIZONT_2}-" # Unicode U+2015 "Horisontal bar"
        CONSOLE_WIDTH=$(($CONSOLE_WIDTH-1))
    done
    # add time at the end
    HORIZONT_2="${HORIZONT_2} \D{"${DATE_PATTERN}"} | command \#"
}

##
# Repository info for PS1
#

repo_info () {
    IS_REPO=
    REPO_INFO=

    IS_REPO=$(__git_ps1)
    if [ -n "$IS_REPO" ]
        then REPO_INFO=$BOLD$IS_REPO$COLOR_END
    fi
    #  add green or red color TODO

}


##
# Init my variables for PS*
#

init_my_variables () {
    horisont_1
    horisont_2
    repo_info
}


##
# PS1
#
get_previos_command_result () {
    if [ $? -eq 0 ]
    then
        PREVIOUS_COMMAND_RESULT="completed"
    else
        PREVIOUS_COMMAND_RESULT="${RED}finished with error${COLOR_END}"
    fi

    echo $PREVIOUS_COMMAND_RESULT
}

init_my_variables
PROMPT_COMMAND=init_my_variables

USER_AND_HOST="[${YELLOW}\u${COLOR_END}${BLUE}@${COLOR_END}${TURQUOISE}\h${COLOR_END}]"
CURRENT_DIR="${DARK_GRAY}\$(pwd)${COLOR_END}"


PS1="${PURPLE}--- $(get_previos_command_result). ${COLOR_END}\n${GREEN}${HORIZONT_1}${COLOR_END}\n${USER_AND_HOST} ${CURRENT_DIR} ${REPO_INFO}\n🌌 "


##
# PS0
#

PS0="${PURPLE}${HORIZONT_2}${COLOR_END}\n"


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




