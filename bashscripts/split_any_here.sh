#!/usr/bin/env bash

set -e

# ----------------------------------------
# usage
# ----------------------------------------

if [ $# -lt 1 ]; then
    echo "Usage: $0 TYPE datafile"
    exit 1
fi

DATAFILE="res.dat"

# ----------------------------------------
# argument → key mapping
# ----------------------------------------
# extend this list freely
for TYPE in "$@"; do
  case "$TYPE" in
      frequency)  key="freq"      outname="omega";;
      phase)      key="phase"     outname="theta";;
      times)      key="ieTimes"   outname="times";;
      popularity) key="t3_f-"     outname="popularity";;
      order)      key="order"     outname="order";;
      *)
          echo "Unknown type: $TYPE"
          echo "Available: frequency, phase, ieTimes, order"
          exit 1
          ;;
  esac

  echo "Searching for key: $key"

  # ----------------------------------------
  # find all indexed keys (freq0, freq1, ...)
  # ----------------------------------------

  indices=$(
      grep -o "${key}[0-9]\+" "$DATAFILE" \
      | sort -u
  )

  # ----------------------------------------
  # split into separate files
  # ----------------------------------------
  first=true

  # if [[ "$TYPE" == "phase" || "$TYPE" == "pop" ]]; then
  if [[ "$TYPE" == "popularity" ]]; then

  cat > "fig_${outname}.plt" <<EOF
set encoding utf8
set datafile separator ','
set key spacing 1.5
set xlabel "popularity (k)"
set ylabel "P(k)"
set logscale xy
set yrange [0.0000001<*:]
set format y "10^{%L}"
set format x "10^{%L}"

EOF

  elif [[ "$TYPE" == "phase" ]]; then 

  cat > "fig_${outname}.plt" <<EOF
set encoding utf8
set datafile separator ','
set key spacing 1.5
set xlabel "phase"
set ylabel "time (s)"

EOF

  elif [[ "$TYPE" == "frequency" ]]; then

  cat > "fig_${outname}.plt" <<EOF
set encoding utf8
set datafile separator ','
set key spacing 1.5
set xlabel "frequency"
set ylabel "time (s)"

EOF

  elif [[ "$TYPE" == "times" ]]; then

  cat > "fig_${outname}.plt" <<EOF
set encoding utf8
set datafile separator ','
set key spacing 1.5
set xlabel "interval number"
set ylabel "inter-event time (s)"

EOF

  elif [[ "$TYPE" == "order" ]]; then

  cat > "fig_${outname}.plt" <<EOF
set encoding utf8
set datafile separator ','
set key spacing 1.5
set xlabel "interval number"
set ylabel "inter-event time (s)"

EOF

  else
  cat > "fig_${outname}.plt" <<EOF
set encoding utf8
set datafile separator ','
set key spacing 1.5

EOF

  fi
  
  if [ -z "$indices" ]; then

    outfile="${outname}.dat"    # e.g. frequency12.dat
    grep -E "(^|[ ,])${key}([ ,]|$)" "$DATAFILE" > "$outfile"
    echo "p \""${outname}.dat"\" using 1:2 with l title \""${outname}"\", \\" \
    >> "fig_${outname}.plt"
  
  else
    for tag in $indices; do
        num="${tag#$key}"                 # extract number (e.g. freq12 → 12)
        outfile="${outname}${num}.dat"    # e.g. frequency12.dat

        grep -E "(^|[ ,])${tag}([ ,]|$)" "$DATAFILE" > "$outfile"
        if [ "$first" = true ]; then
          echo "p \""${outname}${num}.dat"\" using 1:2 with l title \""${outname} ${num}"\", \\" \
          >> "fig_${outname}.plt"
          first=false
        else
          echo "  \""${outname}${num}.dat"\" using 1:2 with l title \""${outname} ${num}"\", \\" \
          >> "fig_${outname}.plt"
        fi

        echo "Created $outfile"
  
    done
  fi
  
  if [[ "$TYPE" == "popularity" ]]; then
    echo "  1 * x ** -0.5 dashtype 2 title \"k^{-0.5}\", \\" \
    >> "fig_${outname}.plt"
    
    echo "  1 * x ** -1.5 dashtype 2 title \"k^{-1.5}\""\
    >> "fig_${outname}.plt"
  fi


done
