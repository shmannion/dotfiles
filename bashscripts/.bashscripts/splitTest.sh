#!/bin/bash

# --- Parse command-line arguments ---
while getopts "n:" opt; do
    case $opt in
        n) n=$OPTARG ;;
        *)
            echo "Usage: $0 -n <number>"
            exit 1
            ;;
    esac
done

# --- Validate that -n was provided ---
if [ -z "$n" ]; then
    echo "Error: -n <number> is required."
    echo "Usage: $0 -n <number>"
    exit 1
fi

# --- Ensure output directories exist ---
mkdir -p temp/pgf temp/meanfield temp/simulation temp/popularity

# --- Main processing loop ---
for ((i=0; i<=n; i++)); do
    echo "Processing i=$i..."

    grep "p${i}"    res.dat > temp/pgf/res_pgf_p${i}.dat
    grep "mf_s${i}" res.dat > temp/meanfield/res_mf_s${i}.dat
    grep "sim_s${i}" res.dat > temp/simulation/res_sim_s${i}.dat
    grep "t1_f${i}" res.dat > temp/popularity/res_t1_f${i}.dat
    grep "t2_f${i}" res.dat > temp/popularity/res_t2_f${i}.dat
    grep "t3_f${i}" res.dat > temp/popularity/res_t3_f${i}.dat
done
