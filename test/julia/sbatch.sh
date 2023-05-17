#!/usr/bin/env bash

# Use strict mode
set -euo pipefail

# Set Julia version to test
export JULIA_VERSION=${JULIA_VERSION:-"1.8.5"}

# Create diretory for Julia environment and Slurm output
mkdir -p "v$JULIA_VERSION"

# Slurm output file
export SBATCH_OUTPUT="$PWD/v$JULIA_VERSION/test_julia_%j.out"

# Puhti batch job
puhti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --output="$SBATCH_OUTPUT" \
        --job-name=test_julia \
        --partition=small \
        --time=00:40:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=20 \
        --mem-per-cpu=2000 \
        test.sh
}

# Mahti batch job
mahti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --output="$SBATCH_OUTPUT" \
        --job-name=test_julia \
        --partition=test \
        --time=00:30:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=128 \
        --mem=0 \
        --exclusive \
        test.sh
}

# LUMI-C batch job
lumi_c() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --output="$SBATCH_OUTPUT" \
        --job-name=test_julia \
        --partition=standard \
        --time=00:30:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=128 \
        --mem=0 \
        --exclusive \
        test.sh
}

# Pass arguments
case $1 in
    puhti) puhti ;;
    mahti) mahti ;;
    lumi_c) lumi_c ;;
    *) exit 1 ;;
esac
