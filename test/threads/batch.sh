#!/bin/bash
#SBATCH --job-name=threads
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4000

srun julia --project=. -t "$SLURM_CPUS_PER_TASK" benchmark.jl
