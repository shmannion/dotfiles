#!/usr/bin/env bash
# Sync new files from project_results to project/data

project_dir="/Users/shman/Desktop/postdoc/cic_tex"
results_dir="/Users/shman/Desktop/postdoc/cic/out"
data_dir="$project_dir/data"
echo "$project_dir"
echo "$results_dir"
echo "Checking for new files in $results_dir..."

# Ensure destination exists
mkdir -p "$data_dir"

# Copy only new (non-existing) files
rsync -av --ignore-existing "$results_dir/" "$data_dir/"

echo "Sync complete: new files (if any) copied to $data_dir."

