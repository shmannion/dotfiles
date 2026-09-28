#!/bin/bash

while getopts "s:t:" opt
do
   case "$opt" in
      s ) source="$OPTARG" ;;
      t ) target="$OPTARG" ;;
   esac
done

scp -i ~/.ssh/dtuHPC shman@login.hpc.dtu.dk:/zhome/cb/c/227890/projects/$source $target
