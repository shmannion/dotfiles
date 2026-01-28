#!/usr/bin/env bash

# Exit on error, undefined var, or failed pipe

usage() {
    echo "Usage: $0 -n <number_of_files> -o <output_file>"
    exit 1
}

# Initialize
while getopts i:n: flag
do
    case "${flag}" in
        i) result=${OPTARG};;
        n) n=${OPTARG};;
    esac
done

# Clean output directories
rm -rf tikzUpload
mkdir tikzUpload

if [[ n -gt 10 ]]; then 
  for ((i=1; i<10; i++)); do
    echo ${i} 
    python3 ~/.pythonscripts/strip_data_for_tikz.py exp_0${i}/split/${result}/res_t3_all.dat tikzUpload/exp_0${i}.dat large $PWD
  done
  for ((i=10; i<=n; i++)); do
    python3 ~/.pythonscripts/strip_data_for_tikz.py exp_${i}/split/${result}/res_t3_all.dat tikzUpload/exp_${i}.dat large $PWD
  done
else
  for ((i=1; i<=n; i++)); do
    python3 ~/.pythonscripts/strip_data_for_tikz.py exp_0${i}/split/${result}/res_t3_all.dat tikzUpload/exp_0${i}.dat large $PWD
  done
fi

