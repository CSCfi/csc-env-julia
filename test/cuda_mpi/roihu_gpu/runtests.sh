#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_cuda_mpi_%j.out
#SBATCH --job-name=test_julia_cuda_mpi
#SBATCH --partition=gpumedium
#SBATCH --time=00:05:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=72
#SBATCH --mem-per-task=120G
#SBATCH --gpus-per-node=4
export TMPDIR=/dev/shm
export UCX_WARN_UNUSED_ENV_VARS=n
module purge
module load julia
#module load julia-mpi
#module load julia-cuda
module list
julia --project=. runtests.jl
EOF
