#!/usr/bin/env bash
set -euo pipefail

JULIA_VERSION=$1
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export JULIA_VERSION SCRIPT_DIR

sbatch \
    --account="$SBATCH_ACCOUNT" \
    --output="test_cuda_%j.out" \
    --job-name="test_cuda" \
    --partition=gpu \
    --time=01:00:00 \
    --nodes=1 \
    --ntasks-per-node=1 \
    --cpus-per-task=10 \
    --mem-per-cpu=4000 \
    --gres=gpu:v100:1 \
    "$SCRIPT_DIR/batch.sh"
