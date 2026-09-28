#!/bin/bash

while getopts i:o:s: flag
do
    case "${flag}" in 
        i) input=${OPTARG};;
        o) out=${OPTARG};;
        s) size=${OPTARG};;
    esac
done

python3 ~/.pythonscripts/strip_data_for_tikz.py $input $out $size $PWD;
