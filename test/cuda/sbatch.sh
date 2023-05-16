#!/usr/bin/env bash

# Use strict mode
set -euo pipefail

# Set Julia version to test
export JULIA_VERSION=${JULIA_VERSION:-"1.8.5"}

# Create diretory for Julia environment and Slurm output
mkdir -p "v$JULIA_VERSION"

# Puthi batch job
puhti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --job-name=test_cuda \
        --partition=gputest \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=10 \
        --mem-per-cpu=4000 \
        --gres=gpu:v100:1 \
        --output="v$JULIA_VERSION/test_cuda_%j.out" \
        test.sh
}

# Mahti batch job
mahti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --job-name=test_cuda \
        --partition=gputest \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=32 \
        --mem-per-cpu=1750 \
        --gres=gpu:a100:1 \
        --output="v$JULIA_VERSION/test_cuda_%j.out" \
        test.sh
}

# Pass arguments
case $1 in
    puhti) puhti ;;
    mahti) mahti ;;
    *) exit 1
esac
