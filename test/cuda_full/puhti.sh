#!/bin/bash
#SBATCH --job-name=cuda_full
#SBATCH --account=project_2001659
#SBATCH --partition=gpu
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4000
#SBATCH --gres=gpu:v100:1
module load julia/1.8.5
export JULIA_NUM_THREADS="$SLURM_CPUS_PER_TASK"
srun julia --project=. test.jl
