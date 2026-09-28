#!/usr/bin/env bash

set -e

# --------------------------------------------
# find highest existing exp_N
# --------------------------------------------

max=0

for d in exp_*; do
    [ -d "$d" ] || continue

    n="${d#exp_}"

    if [[ "$n" =~ ^[0-9]+$ ]]; then
        (( n > max )) && max="$n"
    fi
done

next=$((max + 1))
newdir="exp_$next"

# ---------------------------------------------
# create experiment folder if it does not exist 
# ---------------------------------------------

if [ -d "$newdir" ]; then
    echo "Warning: $newdir already exists"
else
    mkdir -p "$newdir"
    echo "Created $newdir"
fi
