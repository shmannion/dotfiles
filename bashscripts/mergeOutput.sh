#!/usr/bin/env bash

# Exit on error, undefined var, or failed pipe
set -euo pipefail

usage() {
    echo "Usage: $0 -n <number_of_files> -o <output_file>"
    exit 1
}

# Initialize
n=""
output=""

# --- Parse command-line arguments ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        -n)
            if [[ $# -lt 2 ]]; then
                echo "Error: -n requires a numeric argument."
                usage
            fi
            n="$2"
            shift 2
            ;;
        -o)
            if [[ $# -lt 2 ]]; then
                echo "Error: -o requires an output filename."
                usage
            fi
            output="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# --- Validate inputs ---
if [[ -z "$n" || -z "$output" ]]; then
    echo "Error: both -n and -o are required."
    usage
fi

# Verify n is an integer (force numeric context)
if ! [[ "$n" =~ ^[0-9]+$ ]]; then
    echo "Error: -n must be a positive integer (got '$n')."
    exit 1
fi

# Convert n safely to integer
n=$((n + 0))
if (( n <= 0 )); then
    echo "Error: -n must be greater than 0."
    exit 1
fi

# --- Combine files ---
> "$output"

for ((i=1; i<=n; i++)); do
    file="res_${i}.dat"
    if [[ -f "$file" ]]; then
        cat "$file" >> "$output"
    else
        echo "Warning: $file not found, skipping."
    fi
done

echo "Combined res1.dat ... res_${n}.dat into $output"

