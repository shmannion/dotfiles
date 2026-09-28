#!/bin/bash

rm -r temp/pgf
mkdir temp/pgf

cat res.dat | grep p0 > temp/pgf/res_pgf_p0.dat
cat res.dat | grep p1 > temp/pgf/res_pgf_p1.dat

sed -i '' '1i\'$'\n''t, p '$'\n' temp/pgf/*  

