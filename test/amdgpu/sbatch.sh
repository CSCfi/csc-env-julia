#!/usr/bin/env bash

# Use strict mode
set -euo pipefail

_init() {
    # Set Julia version to test
    export JULIA_VERSION=${JULIA_VERSION:-$1}

    # Exit if Julia version is not provided
    [ -z "$JULIA_VERSION" ] && exit 1

    # Create directory for Julia environment and Slurm output
    mkdir -p "v$JULIA_VERSION"

    # Slurm output file
    export SBATCH_OUTPUT="$PWD/v$JULIA_VERSION/test_amdgpu_%j.out"
}

# LUMI batch job
lumi() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --output="$SBATCH_OUTPUT" \
        --job-name=test_amdgpu \
        --partition=dev-g \
        --time=01:00:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --gpus-per-task=2 \
        --cpus-per-task=32 \
        --mem-per-cpu=1750 \
        test.sh
}

# Pass arguments
case $1 in
    lumi)
        _init "$2"
        lumi
        ;;
    *)
        exit 1
        ;;
esac
