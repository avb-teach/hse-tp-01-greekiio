#!/bin/bash

a1="$1"
a2="$2"
in="${a1:1}"
out="${a2:1}"

# unix.stackexchange.com/questions/103078/cp-backup-numbered-for-folders
find "$in" -type f -exec cp --backup=numbered -t "$out" {} +

# unix.stackexchange.com/questions/32409/set-and-shopt-why-two
shopt -s nullglob

for file in "$out"/*.~*~; do
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

    mv -- "$file" "$clearedResult"

done
