#!/bin/bash
#SBATCH --job-name=distributed
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=1000
module load julia/1.8.5
julia --project=. test.jl
