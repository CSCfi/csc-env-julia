#!/bin/bash
#SBATCH --job-name=distributed_threads
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=3
#SBATCH --cpus-per-task=5
#SBATCH --mem=1000
module load julia/1.8.5
export JULIA_NUM_THREADS="$SLURM_CPUS_PER_TASK"
julia --project=. test.jl
