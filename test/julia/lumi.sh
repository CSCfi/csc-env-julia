#!/usr/bin/env bash
set -euo pipefail

JULIA_VERSION=$1
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export JULIA_VERSION SCRIPT_DIR

module use /appl/local/csc/modulefiles

sbatch \
    --account="$SBATCH_ACCOUNT" \
    --output="test_julia_%j.out" \
    --job-name="test_julia" \
    --partition=standard \
    --time=00:30:00 \
    --nodes=1 \
    --ntasks-per-node=1 \
    --cpus-per-task=128 \
    --mem=0 \
    --exclusive \
    "$SCRIPT_DIR/batch.sh"
