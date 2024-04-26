#!/bin/bash

set -x -- 15 next_param

num=$1

shift

findday () for day in monday tuesday wensday
do
    echo "$num : $day \n\n"
    newfunc
    ((num++))
done

newfunc () for word in World
do
    bin/print-command.sh $word
done

findday

set +x
