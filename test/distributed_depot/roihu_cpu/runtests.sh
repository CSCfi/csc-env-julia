#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

sbatch <<EOF
#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --output=test_julia_distributed_depot_%j.out
#SBATCH --job-name=test_julia_distributed_depot
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000

module purge
module load julia
module list

# Distribute the depot dir from Lustre to node local disk (job-specific
# \$TMPDIR, wiped at job end) and unpack it once per node.
DEPOT_DIR="\${TMPDIR}/depot"
srun -N \$SLURM_NNODES --ntasks-per-node=1 ./unpack_depot.sh "\${DEPOT_DIR}"

export JULIA_DEPOT_PATH="\${DEPOT_DIR}:"
srun julia --project=. runtests.jl
EOF
