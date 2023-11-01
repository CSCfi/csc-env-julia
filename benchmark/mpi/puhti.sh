#!/usr/bin/env bash
set -euo pipefail

JULIA_VERSION=$1
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export JULIA_VERSION SCRIPT_DIR

sbatch \
    --account="$SBATCH_ACCOUNT" \
    --output="benchmark_mpi_%j.out" \
    --job-name=benchmark_mpi \
    --partition=test \
    --time=00:15:00 \
    --nodes=2 \
    --ntasks-per-node=1 \
    --cpus-per-task=1 \
    --mem-per-cpu=8000 \
    "$SCRIPT_DIR/batch.sh"
