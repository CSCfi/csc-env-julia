#!/usr/bin/env bash
set -euo pipefail

JULIA_VERSION=$1
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export JULIA_VERSION SCRIPT_DIR

sbatch \
    --account="$SBATCH_ACCOUNT" \
    --output="test_julia_%j.out" \
    --job-name="test_julia" \
    --partition=small \
    --time=00:40:00 \
    --nodes=1 \
    --ntasks-per-node=1 \
    --cpus-per-task=20 \
    --mem-per-cpu=2000 \
    "$SCRIPT_DIR/batch.sh"
