#!/bin/bash

in="$1"
out="$2"

cnt=0
find "$in" -type f | while read f; do
    basename=$(basename "$f")
    ext="${basename##*.}"
    name="${basename%.*}"

    result="${name}"
    ((cnt++))
    if [[ "$name" != "$ext" ]]; then 
        result="$result.${ext}"
    fi

    cp "$f" "$out/$result"
done
