#!/bin/bash
#SBATCH --job-name=distributed
#SBATCH --account=project_2001659
#SBATCH --partition=small
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=1000
module load julia/1.8.5
export JULIA_CPU_THREADS=$SLURM_CPUS_PER_TASK
export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun julia --project=. benchmark.jl
