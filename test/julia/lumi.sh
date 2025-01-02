#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_462000007
#SBATCH --output=test_julia_%j.out
#SBATCH --job-name=test_julia
#SBATCH --partition=standard
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128
#SBATCH --mem-per-cpu=0
#SBATCH --exclusive
module use /appl/local/csc/modulefiles
module load julia
module list
julia runtests.jl
EOF
