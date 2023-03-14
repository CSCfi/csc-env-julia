#!/usr/bin/env bash
module purge
module load StdEnv
module load openmpi/4.1.4
module load cuda/11.7.0
module load julia/1.8.5

# Load packages from default locations
unset JULIA_LOAD_PATH

# Directory for shared Julia depots
export JULIA_DEPOT_PATH="/appl/soft/math/julia/depot"

# Shared Julia environment
export JULIA_PROJECT="/appl/soft/math/julia/depot/environments/v1.8_shared"

# Install and configure packages
julia --project=@ core.jl
