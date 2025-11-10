#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_clustermanagers_%j.out
#SBATCH --job-name=test_julia_clustermanagers
#SBATCH --partition=large
#SBATCH --time=00:05:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1000
module load julia
module list
julia --project=. runtests.jl
EOF
