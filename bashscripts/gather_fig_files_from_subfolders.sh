#!/usr/bin/env bash

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 TYPE [TYPE ...]"
    exit 1
fi

TYPES="$@"

# find sets
SETS=(set*/)
NSETS="${#SETS[@]}"

# grid size
NCOLS=3
NROWS=$(( (NSETS + NCOLS - 1) / NCOLS ))

echo "Found $NSETS sets → layout ${NROWS}x${NCOLS}"

for TYPE in $TYPES; do

    OUTFIG="fig_${TYPE}.plt"
    echo "Creating $OUTFIG"

    # ----------------------------------------
    # header
    # ----------------------------------------

    cat > "$OUTFIG" <<EOF
set terminal qt size 1400,900
set encoding utf8
set datafile separator ','
set key spacing 1.2
set tics scale 0.75

set xlabel "Time"
set ylabel "$TYPE"

set multiplot layout $NROWS,$NCOLS title "$TYPE"

EOF

    # ----------------------------------------
    # plot each set
    # ----------------------------------------

    for setdir in "${SETS[@]}"; do

        setdir="${setdir%/}"
        figfile="$setdir/${TYPE}/fig.plt"

        [ -f "$figfile" ] || continue

        echo "set title \"$setdir\"" >> "$OUTFIG"
        echo "plot \\" >> "$OUTFIG"

        first=true

        while IFS= read -r line; do

            if [[ $line =~ ^[[:space:]]*(p[[:space:]]+)?\" ]]; then

                newline="${line#p }"
                newline="${newline/\"/\"$setdir/${TYPE}/}"

                # strip trailing ", \"
                newline="${newline%, \\}"

                if $first; then
                    first=false
                    echo "  $newline \\" >> "$OUTFIG"
                else
                    echo "  , $newline \\" >> "$OUTFIG"
                fi
            fi

        done < "$figfile"

        echo "" >> "$OUTFIG"
    done

    echo "unset multiplot" >> "$OUTFIG"

done

