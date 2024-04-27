#!/bin/bash


# https://unix.stackexchange.com/questions/295965/how-to-use-find-exec-to-execute-command-in-directory-of-found-file-not-curre
# works not correct, but result is ok.
# todo finished!
find /home/sergey/Forge/rust/* -maxdepth 0 -name '.git' -type d -prune -o -type d -exec sh - 'pwd' {} \;
