##
# Starts personal environment :)
#

# Load files with passwords, ports etc which are not goes into repo or anywere else.
if [ -f $HOME/private_variables.sh ]
then
    chmod 600 $HOME/private_variables.sh
    . $HOME/private_variables.sh
else
    echo File private_variables.sh not exists or accesseble for reading.
fi


##
# Aliases
#

alias df='df -h'
alias du='du -sh'

alias l='ls --group-directories-first -Fv'
alias ll='ls --group-directories-first --human-readable -alFv'

##
# Rewrite standard settings
#

HISTSIZE=1000000
HISTFILESIZE=2000000

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

# Text format
export BOLD='\e[1m'
export UNDERLINED='\e[4m'
export BLINK='\e[5m'

# Background colors. REMEMBER: first must be text color, then background color.
export MAGENTA_BG='\e[45m'
export PURPLE_BG='\e[45m'


##
# Horizont line for PS1
#

horisont_1 () {

    horizont_1=''

    console_width=$COLUMNS # reserve place for time? @TODO with time argument $1

    # create line
    while [ $console_width -gt 0 ]
    do
        horizont_1="${horizont_1}―" # Unicode U+2015 "Horisontal bar"
        console_width=$(( $console_width - 1 ))
    done

    # add time at the end?
    horizont_1="${horizont_1}" #  [\t]

    # final
    echo -en $horizont_1
}

##
# Horizont line for PS0
#
horisont_2 () {

    horizont_2=''

    current_time=$(date +"%A | %d %B | %Y | %T | week %U")
    time_lenght=$(echo $current_time | wc -m)
    line_width=$(( $COLUMNS - $time_lenght - 15 )) # place for time, date and command number

    # create line
    while [ $line_width -gt 0 ]
    do
        horizont_2="${horizont_2}-"
        line_width=$(( $line_width - 1 ))
    done

    # add time at the end
    horizont_2="${horizont_2} ${current_time}"

    # final
    echo -en $horizont_2
}

##
# Repository info for PS1
#

get_repo_info () {

    is_repo=''
    repo_info=''
    repo_description=''

    # branch
    is_repo=$(__git_ps1)
    if [ -n "$is_repo" ]
    then 
        repo_info=$BLUE$is_repo$COLOR_END
    fi

    # repo description
    if [[ -d .git && -f .git/description ]]
    then
        repo_description=$(cat .git/description)
    fi
  
    if echo "$repo_description" | grep "Unnamed repository" > /dev/null
    then
        repo_description="${YELLOW} no description... ${COLOR_END}"
    else
        repo_description="${TURQUOISE} ${repo_description} ${COLOR_END}"
    fi

    # final
    repo_info="${repo_info} ${repo_description}"

    echo -en $repo_info
}


##
# Init my variables for PS*
#

# init_prompt_variables () {
#     horisont_1
#     horisont_2
# }


##
# Is success or fail in previous command ?
#

print_previos_command_result () {

    if [ $? -eq 0 ]
    then
        PREVIOUS_COMMAND_RESULT="completed"
    else
        PREVIOUS_COMMAND_RESULT="${GREEN}finished with error [ code: $? ]${COLOR_END}" # @todo code returns not correct
    fi

    echo -e $PREVIOUS_COMMAND_RESULT
}

##
# Set timer when command was run
# @todo delete when exit from shell.

set_timer () {
    local START=$(date +%s)
    echo -n $START > /tmp/console_command_timer
}

##
# Print current timer value
#
print_timer_result () {
    # todo !! add uniq id for every console in file name - 
    # otherwise timer not correct because two consals will be 
    # use one timer start point.
    if [ -f /tmp/console_command_timer ] 
    then
        local start=$(cat /tmp/console_command_timer)
        local end=$(date +%s)

        timer_result=$(( $end - $start ))
        echo $timer_result
    else
        echo ' -- timer was not set already -- '
    fi
}

##
# Run before every prompt
#

# init_prompt_variables
# PROMPT_COMMAND=init_prompt_variables

##
# PS1
#

USER_AND_HOST="[${YELLOW}\u${COLOR_END}${BLUE}@${COLOR_END}${TURQUOISE}\h${COLOR_END}]"
CURRENT_DIR="${DARK_GRAY}\$(pwd)${COLOR_END}"

PS1="${PURPLE}--- \$(print_previos_command_result) at \$(print_timer_result) seconds. ${COLOR_END}\n${GREEN}\$(horisont_1)${COLOR_END}\n${USER_AND_HOST} ${CURRENT_DIR} \$(get_repo_info)\n🌌 "

##
# PS0
#

PS0="${PURPLE}\$(horisont_2) | command \# ${COLOR_END}\n\$(set_timer)"


# PS1="${GREEN}[\u@\h] \$(pwd) ============================================ [\t]${COLOR_END}\n🌌 "
# output example:
# [sergey@castle]  /home/sergey/Forge/shell ============================================ [15:30:23]
# 🌌 

#  add green or red color TODO in cvs status

# ask confirmation
# user codes must be beetween 64 and 113
# http://tldp.org/LDP/abs/html/exitcodes.html#EXITCODESREF
ask_confirmation () {
  TASK_NAME=$1

  print_dialogue "Greetings, $USER."
  print_dialogue "Do You really want to start $TASK_NAME? (y/n)"
  read -e ANSWER

  if [ $ANSWER = y ]; then
    print_dialogue "Lets try! $TASK_NAME is starting..."
  else
    if [ $ANSWER = n ]; then
      print_warning "This task was canceled."
    else
      print_warning "Sorry, Your answer was not recognized."
    fi
    exit 67
  fi
}

# print computer dialog
print_dialogue () {
  QUESTION=$1
  echo -en $BLUE
  echo $QUESTION
  echo -en $COLOR_END
}

# print warning
print_warning () {
  WARNING=$1
  echo -en $YELLOW
  echo $WARNING
  echo -en $COLOR_END
}

##
# Useful programs for 
#

update () {
    run-command "sudo apt update"
    run-command "sudo apt upgrade"
}

ws () {
    run-command "sudo service apache2 start"
    run-command "sudo service mysql start"
}

wi () {
    run-command "sudo service apache2 status"
    run-command "sudo service mysql status"
}

wf () {
    run-command "sudo service apache2 stop"
    run-command "sudo service mysql stop"
}


##
# TODO
#

# Рефакторинг после прочтения книги.

# debian_chroot
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



