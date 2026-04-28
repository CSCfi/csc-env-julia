#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_hdf5_mpi_%j.out
#SBATCH --job-name=test_julia_hdf5_mpi
#SBATCH --partition=gputest
#SBATCH --time=00:15:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --gpus-per-node=1
module purge
module load gcc/14.3
module load julia
module load julia-mpi
module load hdf5
module list
export UCX_WARN_UNUSED_ENV_VARS=n
srun julia --project=. runtests.jl
EOF
