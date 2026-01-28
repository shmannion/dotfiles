#!/bin/bash

while getopts "s:t:" opt
do
   case "$opt" in
      s ) source="$OPTARG" ;;
      t ) target="$OPTARG" ;;
   esac
done

scp -i ~/.ssh/dtuHPC $source shman@login.hpc.dtu.dk:/zhome/cb/c/227890/$target
