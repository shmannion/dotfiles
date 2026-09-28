#!/usr/bin/env bash

# Exit on error, undefined var, or failed pipe

usage() {
    echo "Usage: $0 -n <number_of_files> -o <output_file>"
    exit 1
}

# Initialize
while getopts i:n:o: flag
do
    case "${flag}" in
        i) input=${OPTARG};;
        n) n=${OPTARG};;
        o) out=${OPTARG};;
    esac
done

# Clean output directories
echo "$out"
rm -rf "$out"
mkdir "$out"
mkdir ${out}/popularity
mkdir ${out}/meanfield
mkdir ${out}/simulation
mkdir ${out}/pgf


for ((i=0; i<n; i++)); do
  cat ${input} | grep "p${i}" > "${out}/pgf/res_pgf_p${i}.dat"
  cat ${input} | grep "mf_s${i}" > "${out}/meanfield/res_mf_s${i}.dat"
  cat ${input} | grep "sim_s${i}" > "${out}/simulation/res_sim_s${i}.dat"
  cat ${input} | grep "t1_f${i}" > "${out}/popularity/res_t1_f${i}.dat"
  cat ${input} | grep "t2_f${i}" > "${out}/popularity/res_t2_f${i}.dat"
  cat ${input} | grep "t3_f${i}" > "${out}/popularity/res_t3_f${i}.dat"
done


cp ${input} "${out}/res.dat"
cat ${input} | grep "t1_f-1" > "${out}/popularity/res_t1_all.dat"
cat ${input} | grep "t2_f-1" > "${out}/popularity/res_t2_all.dat"
cat ${input} | grep "t3_f-1" > "${out}/popularity/res_t3_all.dat"
cat ${input} | grep emergent > "${out}/summary.dat"

sed -i '' '1i\'$'\n''t, p '$'\n' ${out}/popularity/*
sed -i '' '1i\'$'\n''t, s '$'\n' ${out}/simulation/*
sed -i '' '1i\'$'\n''t, s '$'\n' ${out}/meanfield/*
sed -i '' '1i\'$'\n''t, p '$'\n' ${out}/pgf/*
