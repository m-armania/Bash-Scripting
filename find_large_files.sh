#!/bin/bash
if [ $# -ne 2 ]; then
        echo "Usage: $0 <directory> <size>" >&2
        exit 1
fi
dir="$1"
threshold="$2"
if [ ! -d "$dir" ]; then
        echo "Error '$dir' is not a directory" >&2
        exit 1
fi
find "$dir" -type f -size +"$threshold" 2>/dev/null | while read -r file; do
        size=$(du -b "$file" | cut -f1)
        owner=$(stat --format="%U" "$file")
        mtime=$(stat --format="%Y" "$file")
        printf "%s %s %s %s\n" "$size" "$owner" "$mtime" "$file"
        done | sort -rn | awk '{
                #convert $3 (unix timestamp) to a readable date
                cmd="date -d @"$3" +\"%d-%m-%Y %H:%M\""
                cmd | getline mtime
                close(cmd)
                printf "%12d bytes %-20s %-16s %s\n", $1, $2, mtime, $4
                }'
