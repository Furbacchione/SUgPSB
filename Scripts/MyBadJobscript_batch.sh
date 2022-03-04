#!/bin/bash
tail -n +2 MyList.txt | while read problem; do

echo "#!/bin/bash
#PBS -l nodes=1:ppn=9
#PBS -l walltime=72:00:00
#PBS -l mem=16gb
#
# Example (single-core) MATLAB job script
# see http://hpcugent.github.io/vsc_user_docs/
#
# make sure the MATLAB version matches with the one used to compile the MATLAB program!
module load CUTEst/2.0.2-foss-2018b-MATLAB-2018b
# use temporary directory (not \$HOME) for (mostly useless) MATLAB log files
# subdir in \$TMPDIR (if defined, or /tmp otherwise)
export MATLAB_LOG_DIR=\$(mktemp -d -p  \${TMPDIR:-/tmp})
# configure MATLAB Compiler Runtime cache location & size (1GB)
# use a temporary directory in /dev/shm (i.e. in memory) for performance reasons
export MCR_CACHE_ROOT=\$(mktemp -d -p /dev/shm)
export MCR_CACHE_SIZE=2048MB
# change to directory where job script was submitted from
cd \$PBS_O_WORKDIR/$problem
# run compiled example MATLAB program ’example’, provide ’5’ as input argument to the program
# \$EBROOTMATLAB points to MATLAB installation directory

./run_a_Test_Script_$problem.sh \$EBROOTMATLAB
" > jobscript_run_batch_${problem}.sh

qsub jobscript_run_batch_${problem}.sh 

done