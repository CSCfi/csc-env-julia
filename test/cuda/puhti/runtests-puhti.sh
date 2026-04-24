#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_cuda_%j.out
#SBATCH --job-name=test_julia_cuda
#SBATCH --partition=gpu
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=4000
#SBATCH --gres=gpu:v100:1
module load julia
module load julia-cuda
module list
julia --project=. runtests.jl
EOF
