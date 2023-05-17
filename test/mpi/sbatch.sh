#!/usr/bin/env bash

# Use strict mode
set -euo pipefail

# Set Julia version to test
export JULIA_VERSION=${JULIA_VERSION:-"1.8.5"}

# Create diretory for Julia environment and Slurm output
mkdir -p "v$JULIA_VERSION"

# Puhti batch job
puhti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --job-name=test_mpi \
        --partition=test \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=2 \
        --cpus-per-task=4 \
        --mem-per-cpu=500 \
        --output="v$JULIA_VERSION/test_mpi_%j.out" \
        test.sh
}

# Mahti batch job
mahti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --job-name=test_mpi \
        --partition=test \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=2 \
        --cpus-per-task=64 \
        --mem=0 \
        --output="v$JULIA_VERSION/test_mpi_%j.out" \
        test.sh
}

# LUMI-C batch job
lumi_c() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --job-name=test_mpi \
        --partition=debug \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=2 \
        --cpus-per-task=4 \
        --mem-per-cpu=1000 \
        --output="v$JULIA_VERSION/test_mpi_%j.out" \
        test.sh
}

# Pass arguments
case $1 in
    puhti) puhti ;;
    mahti) mahti ;;
    lumi_c) lumi_c ;;
    *) exit 1
esac
