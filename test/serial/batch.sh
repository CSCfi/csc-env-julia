#!/bin/bash
#SBATCH --job-name=serial
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
module load julia/1.8.5
srun julia --project=. benchmark.jl
