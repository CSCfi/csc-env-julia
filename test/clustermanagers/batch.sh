#!/bin/bash
#SBATCH --job-name=clustermanagers
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
module load use.own julia-test/1.8.5
srun julia --project=. test.jl
