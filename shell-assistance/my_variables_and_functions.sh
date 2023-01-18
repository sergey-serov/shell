
alias df='df -h'
alias du='du -sh'

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


##
# Horizont line for PS1
#

horisont () {
    HORIZONT=
    CONSOLE_WIDTH=$(($COLUMNS-11)) # 10 is place for time
    # create line
    while [ $CONSOLE_WIDTH -gt 0 ]
    do
        HORIZONT="${HORIZONT}―" # Unicode U+2015 "Horisontal bar"
        CONSOLE_WIDTH=$(($CONSOLE_WIDTH-1))
    done
    # add time at the end
    HORIZONT="${HORIZONT} [\t]"

    # unset temp vars
    unset CONSOLE_WIDTH
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
# Init my variables
#

init_my_variables () {
    horisont
    repo_info
}


##
# PS1
#

PROMPT_COMMAND=init_my_variables

USER_AND_HOST="[${YELLOW}\u${COLOR_END}${BLUE}@${COLOR_END}${TURQUOISE}\h${COLOR_END}]"
CURRENT_DIR="${DARK_GRAY}\$(pwd)${COLOR_END}"
PS1="${GREEN}${BOLD}${HORIZONT}${COLOR_END}\n${USER_AND_HOST} ${CURRENT_DIR} ${REPO_INFO}\n🌌 "

##
# PS0
#

PS0="${PURPLE}command number: \# \n$HORIZONT${COLOR_END}"


# PS1="${GREEN}[\u@\h] \$(pwd) ============================================ [\t]${COLOR_END}\n🌌 "
# output example:
# [sergey@castle]  /home/sergey/Forge/shell ============================================ [15:30:23]
# 🌌 

##
# TODO
#

# debian_chroot
# ls
# iptables local :))))
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




