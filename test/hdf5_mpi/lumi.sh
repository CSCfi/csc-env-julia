#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_462000007
#SBATCH --output=test_julia_mpi_%j.out
#SBATCH --job-name=test_julia_mpi
#SBATCH --partition=debug
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
module use /appl/local/csc/modulefiles
module load julia
module load julia-mpi
module load cray-hdf5-parallel
module list
srun julia --project=. "$SCRIPT_DIR/runtests.jl"
EOF
