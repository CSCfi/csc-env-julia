#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_462000007
#SBATCH --output=test_julia_amdgpu_%j.out
#SBATCH --job-name=test_julia_amdgpu
#SBATCH --partition=dev-g
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus-per-task=2
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=1750
module use /appl/local/csc/modulefiles
module load julia
module load julia-amdgpu
module list
julia --project=. runtests.jl
EOF
