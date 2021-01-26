#!/bin/bash

output="";

for argument in "$@"; do 
    case $argument in 
        -path=* | --path=* ) 
        output=${argument##*=}
        ;;
    esac;
done;

function compat() {
    if ! [ -x "$(command -v rm)" ]; then 
        echo "[rm -rf] command is not existing"
        exit 0
    fi;

    if ! [[ -d "$output" ]]; then 
        echo "["$output"] No such file or directory"
        exit 0
    fi;

    find "$output" -iname "sess_*" -mtime +3 -type f -exec rm '{}' \;
    find "$output" -iname "sess_*" -mtime +3 -type f -print0 | xargs -0 rm -f
    
    currentDate=`date`;
    echo "Folder files has been deleted at $currentDate" >> /var/log/cron.log
}

compat
