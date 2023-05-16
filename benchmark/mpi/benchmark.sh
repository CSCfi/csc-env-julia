#!/usr/bin/env bash

# Set strict mode
set -euo pipefail

# Load Julia module
module purge
module load "julia/$JULIA_VERSION"
module list

# Set Julia project
export JULIA_PROJECT="$PWD/v$JULIA_VERSION"

# Instantiate the Julia project
julia -e 'import Pkg; Pkg.instantiate()'

# Run the test set
julia benchmark.jl
