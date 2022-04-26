#!/usr/bin/env bash

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 startdate enddate"
    echo "Each date is passed to date -d" 
    exit 1
fi

currdate=$(date -d "$1" '+%F')
enddate=$(date -d "$2" '+%F')

git switch fake-branch || git switch -c fake-branch || exit 2


while ! [[ $currdate > $enddate ]]; do
    echo $currdate >> date-log-file
    faketime "$currdate 12:00" git commit -m "Fake commit $currdate" date-log-file
    currdate=$(date -d "$currdate +1 day" '+%F')
done

git switch -
