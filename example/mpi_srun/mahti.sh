#!/bin/bash
#SBATCH --job-name=openmpi
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=3
module load julia/1.8.5
srun julia --project=. test.jl
