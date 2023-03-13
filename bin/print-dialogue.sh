#!/bin/bash

# author: Sergey Serov

# DESCRIPTION
#############

# HELP
######

# CONFIG
########

# PROGRAM
#########

# TODO
######

# Rewrite!

# WAREHOUSE
###########


# ask confirmation
# user codes must be beetween 64 and 113
# http://tldp.org/LDP/abs/html/exitcodes.html
TASK_NAME=$1

print_dialogue "Greetings, $USER."
print_dialogue "Do You really want to start $TASK_NAME? (y/n)"
read -e ANSWER

if [ $ANSWER = y ]; then
  print_dialogue "Lets try! $TASK_NAME is starting..."
else
  if [ $ANSWER = n ]; then
    print_warning "This task was canceled."
    exit 3
  else
    print_warning "Sorry, Your answer was not recognized."
  fi
  exit 4
fi


# print computer dialog
print_dialogue () {
  QUESTION=$1
  echo -en $BLUE
  echo $QUESTION
  echo -en $COLOR_END
}