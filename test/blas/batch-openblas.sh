#!/bin/bash
#SBATCH --job-name=openblas
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=4000
module load use.own julia-test/1.8.5
srun julia --project=. -t "$SLURM_CPUS_PER_TASK" benchmark.jl -n 10000
