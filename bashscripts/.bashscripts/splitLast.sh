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
rm -rf "$out"
mkdir "$out"
mkdir ${out}/popularity
mkdir ${out}/meanfield
mkdir ${out}/simulation
mkdir ${out}/pgf

i = n-1

cat res.dat | grep "p0" > "${out}/pgf/res_pgf_p0.dat"
cat res.dat | grep "mf_s0" > "${out}/meanfield/res_mf_s0.dat"
cat res.dat | grep "sim_s0" > "${out}/simulation/res_sim_s0.dat"
cat res.dat | grep "t1_f0" > "${out}/popularity/res_t1_f0.dat"
cat res.dat | grep "t2_f0" > "${out}/popularity/res_t2_f0.dat"
cat res.dat | grep "t3_f0" > "${out}/popularity/res_t3_f0.dat"

cat res.dat | grep "p${i}" > "${out}/pgf/res_pgf_p${i}.dat"
cat res.dat | grep "mf_s${i}" > "${out}/meanfield/res_mf_s${i}.dat"
cat res.dat | grep "sim_s${i}" > "${out}/simulation/res_sim_s${i}.dat"
cat res.dat | grep "t1_f${i}" > "${out}/popularity/res_t1_f${i}.dat"
cat res.dat | grep "t2_f${i}" > "${out}/popularity/res_t2_f${i}.dat"
cat res.dat | grep "t3_f${i}" > "${out}/popularity/res_t3_f${i}.dat"


cp res.dat "${out}/res.dat"
cat res.dat | grep t1_f-1 > "${out}/popularity/res_t1_all.dat"
cat res.dat | grep t2_f-1 > "${out}/popularity/res_t2_all.dat"
cat res.dat | grep t3_f-1 > "${out}/popularity/res_t3_all.dat"
cat res.dat | grep emergent > "${out}/summary.dat"

sed -i '' '1i\'$'\n''t, p '$'\n' ${out}/popularity/*
sed -i '' '1i\'$'\n''t, s '$'\n' ${out}/simulation/*
sed -i '' '1i\'$'\n''t, s '$'\n' ${out}/meanfield/*
sed -i '' '1i\'$'\n''t, p '$'\n' ${out}/pgf/*
