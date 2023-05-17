#!/usr/bin/env bash

# Set strict mode
set -euo pipefail

# Load Julia module
module --quiet purge
module load "julia/$JULIA_VERSION"
module list

# Set Julia project
export JULIA_PROJECT="$PWD/v$JULIA_VERSION"

# Instantiate the Julia project
julia -e 'import Pkg; Pkg.instantiate()'

# We use same number of ranks as there are tasks
export JULIA_MPI_TEST_NPROCS="$SLURM_NTASKS_PER_NODE"

# We exclude erroring tests
export JULIA_MPI_TEST_EXCLUDE="test_errorhandler.jl,test_spawn.jl,test_error.jl"

# Run the test set
julia test.jl
