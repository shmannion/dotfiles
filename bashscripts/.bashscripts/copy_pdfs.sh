#!/bin/bash

SRC="$HOME/Downloads"
DEST="$HOME/Desktop/postdoc/mendeley_dump" 

mkdir -p "$DEST"

# Get today's midnight timestamp
MIDNIGHT=$(date -j -f "%Y-%m-%d %H:%M:%S" "$(date +%Y-%m-%d) 00:00:00" "+%s")

find "$SRC" -type f -name "*.pdf" | while IFS= read -r file; do
    
    # Get file modification time (epoch seconds)
    MOD_TIME=$(stat -f "%Sm" -t "%s" "$file")

    if [ "$MOD_TIME" -ge "$MIDNIGHT" ]; then
        filename="$(basename "$file")"

        if [ ! -e "$DEST/$filename" ]; then
            cp "$file" "$DEST/"
            echo "Copied: $filename"
        else
            echo "Skipped (exists): $filename"
        fi
    fi

done

