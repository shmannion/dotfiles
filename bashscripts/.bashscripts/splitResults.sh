#!/bin/bash

rm -r temp/popularity
rm -r temp/meanfield
rm -r temp/simulation
rm -r temp/pgf
mkdir temp/popularity
mkdir temp/meanfield
mkdir temp/simulation
mkdir temp/pgf

cat res.dat | grep p0 > temp/pgf/res_pgf_p0.dat
cat res.dat | grep p1 > temp/pgf/res_pgf_p1.dat
cat res.dat | grep mf_s0 > temp/meanfield/res_mf_s0.dat
cat res.dat | grep mf_s1 > temp/meanfield/res_mf_s1.dat
cat res.dat | grep sim_s0 > temp/simulation/res_sim_s0.dat
cat res.dat | grep sim_s1 > temp/simulation/res_sim_s1.dat
cat res.dat | grep t1_f0 > temp/popularity/res_t1_f0.dat
cat res.dat | grep t2_f0 > temp/popularity/res_t2_f0.dat
cat res.dat | grep t3_f0 > temp/popularity/res_t3_f0.dat
cat res.dat | grep t1_f1 > temp/popularity/res_t1_f1.dat
cat res.dat | grep t2_f1 > temp/popularity/res_t2_f1.dat
cat res.dat | grep t3_f1 > temp/popularity/res_t3_f1.dat
cat res.dat | grep t1_f-1 > temp/popularity/res_t1_all.dat
cat res.dat | grep t2_f-1 > temp/popularity/res_t2_all.dat
cat res.dat | grep t3_f-1 > temp/popularity/res_t3_all.dat
cat res.dat | grep emergent > temp/summary.dat
cp res.dat temp/res.dat



sed -i '' '1i\'$'\n''t, p '$'\n' temp/popularity/*
sed -i '' '1i\'$'\n''t, s '$'\n' temp/simulation/*  
sed -i '' '1i\'$'\n''t, s '$'\n' temp/meanfield/*    
sed -i '' '1i\'$'\n''t, p '$'\n' temp/pgf/*  
