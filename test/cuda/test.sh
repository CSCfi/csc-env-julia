#!/usr/bin/env bash

# Set strict mode
set -euo pipefail

# Load Julia module
module --quiet purge
module load "julia-cuda/$JULIA_VERSION"
module list

# Set Julia project
export JULIA_PROJECT="$PWD/v$JULIA_VERSION"

# Instantiate the Julia project
julia -e 'import Pkg; Pkg.instantiate()'

# Run the test set
julia test.jl
