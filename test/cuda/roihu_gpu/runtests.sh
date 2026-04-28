#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_cuda_%j.out
#SBATCH --job-name=test_julia_cuda
#SBATCH --partition=gpumedium
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=72
#SBATCH --mem=120G
#SBATCH --gpus-per-node=1
module purge
module load julia
module load julia-cuda
module list
#export TMPDIR=/dev/shm
export UCX_WARN_UNUSED_ENV_VARS=n
julia --project=. runtests.jl
EOF
