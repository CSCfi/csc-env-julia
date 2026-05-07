#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_slurmclustermanager_%j.out
#SBATCH --job-name=test_julia_slurmclustermanager
#SBATCH --partition=test
#SBATCH --time=00:05:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=384
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=0
module purge
module load julia
module list
#export JULIA_DEBUG=all
julia --project=. runtests.jl
EOF
