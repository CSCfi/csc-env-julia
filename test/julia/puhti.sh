#!/bin/bash
#SBATCH --job-name=test_julia
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000
module load julia/1.8.5
export JULIA_CPU_THREADS="$((SLURM_TASKS_PER_NODE - 1))"
export JULIA_NUM_THREADS="$SLURM_CPUS_PER_TASK"
julia --project=. test.jl
