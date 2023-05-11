#!/usr/bin/env bash

# Set strict mode
set -euo pipefail

# Load Julia module
module load julia/$JULIA_VERSION

# Set Julia project
export JULIA_PROJECT="$PWD/v$JULIA_VERSION"

# Instantiate the Julia project
julia -e 'import Pkg; Pkg.instantiate()'

# Run the Julia test set
julia test.jl
