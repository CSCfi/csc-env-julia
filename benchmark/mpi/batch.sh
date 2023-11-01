#!/usr/bin/env bash
set -euo pipefail

# Load Julia module
module --quiet purge
module load "julia/$JULIA_VERSION"
module list

# Run the benchmarks
julia benchmark.jl
