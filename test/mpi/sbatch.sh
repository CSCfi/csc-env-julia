#!/usr/bin/env bash

if [ -z "$SBATCH_ACCOUNT" ]; then
    echo "SBATCH_ACCOUNT should be set!" >&2
    exit 1
fi

# Set Julia version to test
export JULIA_VERSION=${JULIA_VERSION:-"1.8.5"}

# Create diretory for Julia environment and Slurm output
mkdir -p "v$JULIA_VERSION"

# Batch scripts

puhti() {
    sbatch \
        --job-name=test_mpi \
        --partition=test \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=2 \
        --cpus-per-task=4 \
        --mem-per-cpu=500 \
        --output="v$JULIA_VERSION/slurm-%j.out" \
        test.sh
}

mahti() {
    sbatch \
        --job-name=test_mpi \
        --partition=test \
        --time=00:15:00 \
        --nodes=1 \
        --ntasks-per-node=2 \
        --cpus-per-task=64 \
        --mem=0 \
        --output="v$JULIA_VERSION/slurm-%j.out" \
        test.sh
}

# Pass arguments
"$@"
