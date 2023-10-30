#!/usr/bin/env bash

# Set strict mode
set -euo pipefail

# Load Julia module
module --quiet purge
module load "julia/$JULIA_VERSION"
module list

# Run the test set
julia runtests.jl
