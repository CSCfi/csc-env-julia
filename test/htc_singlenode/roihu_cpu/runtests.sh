#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_htc_%j.out
#SBATCH --job-name=test_julia_htc
#SBATCH --partition=medium
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=384
#SBATCH --mem-per-cpu=0
module purge
module load julia
module list
julia --project=. runtests.jl
EOF
