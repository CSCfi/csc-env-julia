#!/usr/bin/env bash

# Use strict mode
set -euo pipefail

# Set Julia version to test
export JULIA_VERSION=${JULIA_VERSION:-"1.8.5"}

# Create diretory for Julia environment and Slurm output
mkdir -p "v$JULIA_VERSION"

# Slurm output file
export SBATCH_OUTPUT="$PWD/v$JULIA_VERSION/benchmark_mpi_%j.out"

# Puhti batch job
puhti() {
    sbatch \
        --account="$SBATCH_ACCOUNT" \
        --output="$SBATCH_OUTPUT" \
        --job-name=benchmark_mpi \
        --partition=test \
        --time=00:15:00 \
        --nodes=2 \
        --ntasks-per-node=1 \
        --cpus-per-task=1 \
        --mem-per-cpu=8000 \
        ./benchmark.sh
}

# Pass arguments
case $1 in
    puhti) puhti ;;
    *) exit 1 ;;
esac
