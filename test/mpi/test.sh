#!/usr/bin/env bash

# Set strict mode
set -euo pipefail

# Load Julia module
module load julia/$JULIA_VERSION

# Set Julia project
export JULIA_PROJECT="$PWD/v$JULIA_VERSION"

# Instantiate the Julia project
julia -e 'import Pkg; Pkg.instantiate()'

# Run the test set
export JULIA_MPI_TEST_NPROCS=$SLURM_NTASKS_PER_NODE
export JULIA_MPI_TEST_EXCLUDE="test_errorhandler.jl,test_spawn.jl,test_error.jl"
julia test.jl
