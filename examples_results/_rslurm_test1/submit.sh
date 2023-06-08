#!/bin/bash
#
#SBATCH --array=0-19
#SBATCH --cpus-per-task=4
#SBATCH --job-name=test1
#SBATCH --output=slurm_%a.out
#SBATCH --time=23:00:00
#SBATCH --partition=core
#SBATCH --mem-per-cpu=16G
/opt/scp/software/R/4.1.0-foss-2019a-core/lib64/R/bin/Rscript --vanilla slurm_run.R
