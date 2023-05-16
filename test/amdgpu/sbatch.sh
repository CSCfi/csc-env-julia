#!/usr/bin/env bash

# Use strict mode
set -euo pipefail

# Set Julia version to test
export JULIA_VERSION=${JULIA_VERSION:-"1.9.0"}

# Create diretory for Julia environment and Slurm output
mkdir -p "v$JULIA_VERSION"

# LUMI-G batch job
lumi_g() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --job-name=test_amdgpu \
        --partition=dev-g \
        --time=01:00:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --gpus-per-task=2 \
        --cpus-per-task=32 \
        --mem-per-cpu=1750 \
        --output="v$JULIA_VERSION/test_amdgpu_%j.out" \
        test.sh
}

# Pass arguments
case $1 in
    lumi_g) lumi_g ;;
    *) exit 1 ;;
esac
