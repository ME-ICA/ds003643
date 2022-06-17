#!/bin/bash
#SBATCH --job-name=lpp-dwn
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --account=iacc_nbc
#SBATCH --qos=qos_download
#SBATCH --partition=download
# Outputs ----------------------------------
#SBATCH --output=/home/data/nbc/external-datasets/ds003643/code/jobs/download.out
#SBATCH --error=/home/data/nbc/external-datasets/ds003643/code/jobs/download.err
# ------------------------------------------
pwd; hostname; date
set -e

module load singularity-3.5.3

mkdir /home/tsalo006/ds003643-temp/
mkdir /home/tsalo006/ds003643/

cd /home/tsalo006/ds003643-temp/

singularity run \
    /home/data/cis/singularity-images/datalad_fullmaster.sif \
    install https://github.com/OpenNeuroDatasets/ds003643.git /home/tsalo006/ds003643-temp/

singularity run \
    /home/data/cis/singularity-images/datalad_fullmaster.sif 
    get /home/tsalo006/ds003643-temp/sub-*/*

singularity run \
    /home/data/cis/singularity-images/datalad_fullmaster.sif \
    unlock /home/tsalo006/ds003643-temp/

cp -LR /home/tsalo006/ds003643-temp/ /home/tsalo006/ds003643/
