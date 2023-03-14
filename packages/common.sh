#!/usr/bin/env bash
module purge
module load julia/1.8.5

# Directory for shared Julia depots
export JULIA_DEPOT_PATH="/appl/soft/math/julia/depot"

# Shared Julia environment
export JULIA_PROJECT="/appl/soft/math/julia/depot/environments/v1.8_shared"
