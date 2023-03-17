#!/bin/bash
#SBATCH --job-name=cuda
#SBATCH --account=project_2001659
#SBATCH --partition=gputest
#SBATCH --time=00:15:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000
#SBATCH --gres=gpu:v100:1
module load julia/1.8.5-openmpi-cuda
srun julia --project=. test.jl