#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

DRY_RUN=false   # set true for a dry run

for j in $(seq 1 16); do
  # use an exact match pattern to avoid Pair1 matching Pair10, etc.
  for file in Pair${j}*; do
    [[ -e "$file" ]] || continue

    # strip off only the exact "Pair" + number portion
    rest="${file#Pair${j}}"

    # pad only if j < 10
    if (( j < 10 )); then
      newname="pair_0${j}${rest}"
    else
      newname="pair_${j}${rest}"
    fi

    if [ "$DRY_RUN" = true ]; then
      printf "Would rename: %s -> %s\n" "$file" "$newname"
    else
      mv -- "$file" "$newname"
      printf "Renamed: %s -> %s\n" "$file" "$newname"
    fi
  done
done
for file in pair_010* ; do mv $file ${file//010/10} ; done
for file in pair_011* ; do mv $file ${file//011/11} ; done
for file in pair_012* ; do mv $file ${file//012/12} ; done
for file in pair_013* ; do mv $file ${file//013/13} ; done
for file in pair_014* ; do mv $file ${file//014/14} ; done
for file in pair_015* ; do mv $file ${file//015/15} ; done
for file in pair_016* ; do mv $file ${file//016/16} ; done
