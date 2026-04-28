#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_mpi_%j.out
#SBATCH --job-name=test_julia_mpi
#SBATCH --partition=small
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
module purge
module load julia
module load julia-mpi
module list
#export TMPDIR=/dev/shm
export UCX_WARN_UNUSED_ENV_VARS=n
julia --project=. runtests.jl
EOF
