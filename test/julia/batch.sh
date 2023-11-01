#!/usr/bin/env bash
set -euo pipefail

# Set the environment
module --quiet purge
module load "julia/$JULIA_VERSION"
module list

# Run the tests
julia "$SCRIPT_DIR/runtests.jl"
