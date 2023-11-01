#!/usr/bin/env bash
set -euo pipefail

# Set the environment
module --quiet purge
module load "julia/$JULIA_VERSION"
module list

# We use same number of ranks as there are tasks
export JULIA_MPI_TEST_NPROCS="$SLURM_NTASKS"

# We exclude erroring tests
export JULIA_MPI_TEST_EXCLUDE="test_errorhandler.jl,test_spawn.jl,test_error.jl"

# Run the tests
julia "$SCRIPT_DIR/runtests.jl"
