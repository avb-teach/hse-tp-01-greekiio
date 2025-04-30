#!/bin/bash

if [ $# -ne 2 ]; then
    exit 1
fi

# unix.stackexchange.com/questions/103078/cp-backup-numbered-for-folders
find "$1" -type f -exec cp --backup=numbered -t "$2" {} +

for file in "$2"/*.~*~; do
    # www.linux.org.ru/forum/general/2639961
    curExt="${file%.*}"
    ext="${curExt##*.}"

    addedBackup="${file##*.}"
    cur="${file%%.*}"
    result="${cur}${addedBackup}"

    # stackoverflow.com/questions/4181703/how-to-concatenate-string-variables-in-bash
    if [ "$cur" != "$ext" ]; then
        result="$result.${ext}"
    fi

    # www.linux.org.ru/forum/general/2003823
    clearedResult="${result//\~/}"

    cp -- "$file" "$clearedResult"
    rm -- "$file"

done
