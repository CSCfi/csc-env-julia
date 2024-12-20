#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_mpi_%j.out
#SBATCH --job-name=test_julia_mpi
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=64
#SBATCH --mem-per-cpu=0
#SBATCH --exclusive
module load julia
module load julia-mpi
module list
julia "$SCRIPT_DIR/runtests.jl"
EOF
