#!/bin/bash
#SBATCH --job-name=openmpi_cuda
#SBATCH --account=project_2001659
#SBATCH --partition=gputest
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --gres=gpu:v100:2
module load julia/1.8.5
srun julia --project=. test.jl
