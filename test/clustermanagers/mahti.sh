#!/usr/bin/env bash
set -euo pipefail

JULIA_VERSION=$1
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export JULIA_VERSION SCRIPT_DIR

sbatch \
    --account="$SBATCH_ACCOUNT" \
    --output="test_clustermanagers_%j.out" \
    --job-name="test_clustermanagers" \
    --partition=medium \
    --time=00:05:00 \
    --nodes=2 \
    --ntasks-per-node=2 \
    --cpus-per-task=64 \
    --mem=0 \
    --exclusive \
    "$SCRIPT_DIR/batch.sh"
