#!/bin/bash
#SBATCH --job-name=benchmark_mpi
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
module load julia/1.8.5
srun julia --project=. benchmark.jl
