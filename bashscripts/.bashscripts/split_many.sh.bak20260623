#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SPLIT_ANY="$SCRIPT_DIR/split_any.sh"
SPLIT_ANY_HERE="$SCRIPT_DIR/split_any_here.sh"
GATHER_PLOTS="$SCRIPT_DIR/gather_fig_files.sh"
GATHER_PLOTS_SUBFOLDERS="$SCRIPT_DIR/gather_fig_files_from_subfolders.sh"
set -e

if [ $# -lt 2 ]; then
    echo "Usage:"
    echo "  $0 N TYPE [TYPE ...]"
    echo
    echo "Example:"
    echo "  $0 3 frequency ieTimes"
    exit 1
fi

N="$1"
shift

subs="$1"

if [[ "$subs" == "subfolders" ]]; then
  shift
  echo "Splitting with subdirectories"
fi  

TYPES="$@"

# ----------------------------------------
# sanity check
# ----------------------------------------

if ! [[ "$N" =~ ^[0-9]+$ ]]; then
    echo "Error: N must be an integer"
    exit 1
fi

# ----------------------------------------
# loop over result files
# ----------------------------------------

for ((i=1; i<=N; i++)); do
    setdir=$(printf "set%02d" "$i")
    # setdir="set${i}"
    
    (
      cd "$setdir"
      if [[ "$subs" == "subfolders" ]]; then
        "$SPLIT_ANY" $TYPES
      
      else
        "$SPLIT_ANY_HERE" $TYPES
      fi
    )
    echo "======================================"
    echo "Processing $resfile → $setdir"
    echo "======================================"

done

if [[ "$subs" == "subfolders" ]]; then
  "$GATHER_PLOTS_SUBFOLDERS" $TYPES
else
  "$GATHER_PLOTS" $TYPES
fi
# for TYPE in "$@"; do
#   cat > "fig_${TYPE}.plt" <<EOF
# set encoding utf8
# set datafile separator ','
# set key spacing 1.5

# EOF
# done
