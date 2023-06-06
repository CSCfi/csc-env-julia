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
    export SBATCH_OUTPUT="$PWD/v$JULIA_VERSION/test_cuda_%j.out"
}

# Puthi batch job
puhti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --output="$SBATCH_OUTPUT" \
        --job-name=test_cuda \
        --partition=gputest \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=10 \
        --mem-per-cpu=4000 \
        --gres=gpu:v100:1 \
        test.sh
}

# Mahti batch job
mahti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --output="$SBATCH_OUTPUT" \
        --job-name=test_cuda \
        --partition=gputest \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=32 \
        --mem-per-cpu=1750 \
        --gres=gpu:a100:1 \
        test.sh
}

# Pass arguments
case $1 in
    puhti)
        _init "$2"
        puhti
        ;;
    mahti)
        _init "$2"
        mahti
        ;;
    *)
        exit 1
        ;;
esac
