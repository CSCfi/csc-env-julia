#!/bin/bash
#SBATCH --job-name=test_julia
#SBATCH --account=project_2001659
#SBATCH --partition=small
#SBATCH --time=00:40:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=2000
module load julia/1.8.5
export JULIA_CPU_THREADS=$SLURM_CPUS_PER_TASK
export JULIA_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun julia --project=. test.jl
