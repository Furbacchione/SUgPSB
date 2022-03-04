#!/bin/bash

# set -e

module load CUTEst/2.0.2-foss-2018b-MATLAB-2018b

tail -n +2 MyList.txt | while read p; do

NAME=$1

cp a_Test_Script.m ${p}

cp -r simple_example ${p}

cp -r Auxillary_functions ${p}

cd ${p}

mcc -mv ${NAME}.m -I Auxillary_functions -I simple_example -o ${NAME}_${p}

sed -i 's/LD_LIBRARY_PATH=\./LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:./g' run_${NAME}_${p}.sh

echo "To run, use './run_${NAME}_${p}.sh \$EBROOTMATLAB'."

cd ..

done
