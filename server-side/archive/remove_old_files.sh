#! /bin/bash
find . -type f -mtime +60 -exec rm -f {} \;
