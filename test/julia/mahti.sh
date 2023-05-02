#!/bin/bash
#SBATCH --job-name=test_julia
#SBATCH --partition=test
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128

module load julia/1.8.5
julia --project=. -e 'import Pkg; Pkg.instantiate()'
srun julia --project=. test.jl
