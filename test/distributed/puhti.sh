#!/bin/bash
#SBATCH --job-name=distributed
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=3
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
module load julia/1.8.5
julia --project=. test.jl
