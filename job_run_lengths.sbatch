#!/bin/bash
#SBATCH --job-name=lpp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --account=iacc_nbc
#SBATCH --qos=pq_nbc
#SBATCH --partition=investor

# Outputs ----------------------------------
#SBATCH --output=run_lengths.out
#SBATCH --error=run_lengths.err
########################################################
# A generic Python job for the SLURM scheduler
export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=4
. $MODULESHOME/../global/profile.modules
source /home/data/nbc/misc-projects/Salo_PowerReplication/code/activate_environment

python check_run_lengths.py
