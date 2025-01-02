#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_462000007
#SBATCH --output=test_julia_rocm_aware_mpi_%j.out
#SBATCH --job-name=test_julia_rocm_aware_mpi
#SBATCH --partition=dev-g
#SBATCH --time=00:05:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=1750
module use /appl/local/csc/modulefiles
module load julia
module load julia-mpi
module load julia-amdgpu
module list
srun julia --project=. runtests.jl
EOF
