#!/usr/bin/env bash
set -euo pipefail

# Run from parent directory that contains pair1..pair16
# Creates 120/comp/ and moves files into it.

# Prepare destination directories
mkdir -p 96/{self,comp,other,leader_follower_1,leader_follower_2}

shopt -s nullglob   # important: make globs with no matches expand to nothing

for pairdir in Pair*/; do
    # pairdir looks like "pair1/" or "pair16/"
    pairname=$(basename "$pairdir")       # e.g. pair1
    pairnum=${pairname#pair}              # e.g. 1

    srcdir="${pairdir}96"
    [ -d "$srcdir" ] || continue          # skip if pairX/120 doesn't exist

    # collect unique trial prefixes (the first number before first underscore)
    prefixes=()
    for f in "$srcdir"/*_1-2_2-2.mid; do
        # if no files, the loop will be skipped thanks to nullglob
        base=$(basename "$f")
        prefix=${base%%_*}                # get part before first underscore
        prefixes+=("$prefix")
    done

    # if no matching files found for this pair, continue
    if [ ${#prefixes[@]} -eq 0 ]; then
        continue
    fi

    # get sorted unique prefixes
    IFS=$'\n' sorted_unique_prefixes=($(printf "%s\n" "${prefixes[@]}" | sort -n -u))
    unset IFS

    # per-pair trial numbering starts at 1
    trial_num=1
    for prefix in "${sorted_unique_prefixes[@]}"; do
        # match both candidate files for this prefix if present
        for f in "$srcdir"/${prefix}_*_1-2_2-2.mid; do
            [ -e "$f" ] || continue
            base=$(basename "$f")

            # extract candidate number (assumes candidate is the number between first and second underscores)
            # e.g., 22_1_trial.mid -> candidate 1
            candidate=$(echo "$base" | awk -F'_' '{print $2}')

            # construct new name and move (no overwrite)
            newname="${pairnum}_c${candidate}_t${trial_num}.mid"

            # If you prefer to avoid overwriting existing files, use mv -n. We'll check and fail-safe:
            dest="96/leader_follower_2/$newname"
            if [ -e "$dest" ]; then
                # if destination already exists, append unique suffix
                suffix=1
                while [ -e "${dest%.mid}_dup${suffix}.mid" ]; do
                    ((suffix++))
                done
                dest="${dest%.mid}_dup${suffix}.mid"
            fi

            cp -- "$f" "$dest"
            echo "Moved: $f -> $dest"
        done

        ((trial_num++))
    done
done

echo "Done."

