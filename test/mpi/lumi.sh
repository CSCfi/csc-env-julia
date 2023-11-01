#!/usr/bin/env bash
set -euo pipefail

JULIA_VERSION=$1
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export JULIA_VERSION SCRIPT_DIR

module use /appl/local/csc/modulefiles

sbatch \
    --account="$SBATCH_ACCOUNT" \
    --output="test_mpi_%j.out" \
    --job-name="test_mpi" \
    --partition=debug \
    --time=00:15:00 \
    --nodes=1 \
    --ntasks-per-node=2 \
    --cpus-per-task=4 \
    --mem-per-cpu=1000 \
    "$SCRIPT_DIR/batch.sh"
