#!/bin/bash
#SBATCH --job-name=test_cuda
#SBATCH --account=project_2001659
#SBATCH --partition=gputest
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
module load julia/1.8.5
export JULIA_CPU_THREADS="$SLURM_CPUS_PER_TASK"
export JULIA_NUM_THREADS="$SLURM_CPUS_PER_TASK"
srun julia --project=. test.jl
