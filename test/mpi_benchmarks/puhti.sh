#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_mpi_benchmarks_%j.out
#SBATCH --job-name=test_julia_mpi_benchmarks
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
module load julia
module load julia-mpi
module list
julia "$SCRIPT_DIR/runtests.jl"
EOF
