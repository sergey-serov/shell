##
# Starts personal environment :)
#

#
# Load files with passwords, ports etc which are not goes into repo or anywere else.
#
if [ -f $HOME/private_variables.sh ]
then
    chmod 600 $HOME/private_variables.sh
    . $HOME/private_variables.sh
else
    echo File private_variables.sh not exists or accesseble for reading.
fi

#
# Create my.cnf with private access credentials
# Now when we run just 'mysql' (without -u and -p) - we works
# with root priviliges.
# For work with other credetntials define -u -p -h params.
#
if [ -n "$MYSQL_ADMIN" -a -n "$MYSQL_PASSWORD" ]
then
    echo "
# mysql --print-defaults

[mysql]
    user=$MYSQL_ADMIN
    password=$MYSQL_PASSWORD
[mysqldump]
    user=$MYSQL_ADMIN
    password=$MYSQL_PASSWORD
" > ~/.my.cnf
fi

# todo iptables


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

##
# Horizont line for PS1
#

print_horizont_1 () {

    horizont_1=''
    console_width=$COLUMNS

    # create line
    while [ $console_width -gt 0 ]
    do
        horizont_1="$horizont_1―" # Unicode U+2015 "Horisontal bar"
        console_width=$(( console_width - 1 ))
    done

    # final
    echo -en $horizont_1
}

# export HORIZONT_1=$(print_horisont_1) # problem: not changes width after resize.

##
# Horizont line for PS0
#
print_horizont_2 () {

    horizont_2=''
    line_width=$COLUMNS

    current_time=$(date +"%A | %d %B | %Y | %T | week %U")
    time_lenght=$(echo $current_time | wc -m)
    line_width=$(( COLUMNS - time_lenght - 15 )) # place for time, date and command number

    # create line
    while [ $line_width -gt 0 ]
    do
        horizont_2="$horizont_2-"
        line_width=$(( line_width - 1 ))
    done

    # add time at the end
    horizont_2="$horizont_2 $current_time"

    # final
    echo -en $horizont_2
}

# export HORIZONT_2=$(print_horizont_2) # problem: not changes width after resize.

##
# Repository info for PS1
#
#  @TODO add green or red color in vcs status
print_repo_info () {

    branch=''
    repo_info=''
    repo_description=''

    # branch
    branch=$(__git_ps1)
    if [ -n "$branch" ]
    then
        repo_info="$BLUE $branch $COLOR_END"

    else # this is not a vcs repository
        exit 0
    fi

    # repo description
    if [[ -e .git && -d .git && -f .git/description && -s .git/description ]]
    then
        repo_description=$(cat .git/description)
        if echo "$repo_description" | grep "^Unnamed repository" > /dev/null
        then
            repo_description="$YELLOW no description... $COLOR_END"
        else
            repo_description="$TURQUOISE $repo_description $COLOR_END"
        fi
    fi

    # final
    repo_info="$repo_info $repo_description"

    echo -en $repo_info
}

##
# Is success or fail in previous command?
#

print_previous_command_exit_code () {

    exit_code=$?

    if [ $exit_code -eq 0 ]
    then
        output="completed"
    else
        output="$RED [!] finished with error [ code: $exit_code ] $COLOR_END"
    fi

    echo -e $output
}

##
# Set timer when command was run
# @todo delete when exit from shell.

set_timer () {
    start=$(date +%s)
    echo -n $start > /tmp/console_command_timer_$$
}

##
# Print current timer value
#
print_timer_result () {
    if [ -f /tmp/console_command_timer_$$ ]
    then
        start=$(cat /tmp/console_command_timer_$$)
        end=$(date +%s)

        timer_result=$(( end - start ))
        echo "$timer_result seconds."
    else
        echo ' -- timer was not set already -- '
    fi
}

##
# PS1
#

USER_AND_HOST="[$YELLOW\u$COLOR_END$BLUE@$COLOR_END$TURQUOISE\h$COLOR_END]"
CURRENT_DIR="$DARK_GRAY\$(pwd)$COLOR_END"
PREVIOUS_COMMAND_RESULT="$PURPLE--- \$(print_previous_command_exit_code) at \$(print_timer_result) $COLOR_END"

PS1="$PREVIOUS_COMMAND_RESULT\n$GREEN\$(print_horizont_1)$COLOR_END\n$USER_AND_HOST $CURRENT_DIR \$(print_repo_info)\n🌌 "

##
# PS0
#

PS0="${PURPLE}\$(print_horizont_2) | command \# ${COLOR_END}\n\$(set_timer)"

# PS1="${GREEN}[\u@\h] \$(pwd) ============================================ [\t]${COLOR_END}\n🌌 "
# output example:
# [sergey@castle]  /home/sergey/Forge/shell ============================================ [15:30:23]
# 🌌

##
# PS4 (debug mode with set -x)
#
# export PS4='+[line ${LINENO}]: }'
# export PS4='+${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
export PS4='+ $(printf "%s %3d" line ${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

##
# Greetings
#
# TODO add $(days) -- another name will be good maybe

##
# Messages from system
#

if test -s ~/.messages_from_system
then
    :
    # TODO
fi

##
# Goodbye
#
trap "echo 'import this' | python3; sleep 100; exit" 0


##
# Useful programs for work
#

update () {
    run-command "sudo apt update"
    run-command "sudo apt upgrade"
}

ws () {
    run-command "sudo service apache2 start"
    run-command "sudo service mysql start"
}

wi () { # todo: add parametr v for full output and by deafult short status message.
    run-command "sudo service apache2 status"
    run-command "sudo service mysql status"
}

wf () {
    run-command "sudo service apache2 stop"
    run-command "sudo service mysql stop"
}

update_phpstorm_eap () {
    run-command "rm -rfv /opt/phpstorm/*"
    run-command "cp -rv $HOME/Downloads/PhpStorm/* /opt/phpstorm"
}


currently () {
    print-info "Make backup."
    print-info "1). Database."

    copy_name=$(date +"%F_%H-%M")
    run-command "$SHELL_HOME/mysql/database_to_file.sh $CURRENTLY_DATABASE $BACKUP_HOME/$copy_name.sql"

    print-info "2). Files."
    run-command "tar -czf $BACKUP_HOME/$copy_name.gz $CURRENTLY_SITE"

    print-info "Used space:"
    run-command "du $BACKUP_HOME"

    print-info "Free space:"
    run-command "df $HOME" # todo add new function + in welcome message

    print-info "Version control routine."
    print-command "cd $CURRENTLY_CODE"
    cd $CURRENTLY_CODE

    run-command "git status"
}

##
# TODO
#

# small hight beuty sound in PS finish.

# debian_chroot
# statistics for apps which uses network!
# top, df - welcome message

# !!!!!!!!!!!!!!!!!!!!!
# backup /var/www every morning before work!
# dump all databases before work at the mornign!

##
# Warehouse
#
# Kat Dog
# PS1="$HORIZONT
# # time: \t
# # user: \u
# # host: \H
# # path: \w
# # repo: $REPO_INFO
# > "
# 💐🌳

# Run before every prompt
# PROMPT_COMMAND=init_prompt_variables

# Init my variables for PS*
# init_prompt_variables () {
#     print_horizont_1
#     print_horizont_2
# }


