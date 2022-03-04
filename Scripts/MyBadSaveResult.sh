#!/bin/bash

# set -e

now=$(date +"%Y%m%d%H%M")

mkdir ${now}_MySave 

mkdir ${now}_MySave/archives 

tail -n +2 MyList.txt | while read p; do

cp ${p}/saved_result_${p}.mat ${now}_MySave 

mv ${p}/ ${now}_MySave/archives 

mv jobscript_run_batch_${p}* ${now}_MySave/archives


done
