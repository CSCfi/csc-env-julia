#!/bin/bash

# Set Julia version to test
JULIA_VERSION=${JULIA_VERSION:-"1.9.0"}

# Create diretory for Julia environment and Slurm output
mkdir -p "v$JULIA_VERSION"

# Batch scripts

puhti() {
    sbatch \
        --job-name=test_julia \
        --partition=small \
        --time=00:40:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=20 \
        --mem-per-cpu=2000 \
        --output="v$JULIA_VERSION/slurm-%j.out" \
        test.sh
}

mahti() {
    sbatch \
        --job-name=test_julia \
        --partition=test \
        --time=00:30:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=128 \
        --mem=0 \
        --output="v$JULIA_VERSION/slurm-%j.out" \
        test.sh
}

lumi_c() {
    sbatch \
        --job-name=test_julia \
        --partition=small \
        --time=00:30:00 \
        --nodes=1 \
        --ntasks-per-node=1 \
        --cpus-per-task=40 \
        --mem-per-cpu=1750 \
        --output="v$JULIA_VERSION/slurm-%j.out" \
        test.sh
}

# Pass arguments
"$@"
