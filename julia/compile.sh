#!/usr/bin/env sh
set -eu

# Setup the environment for the installation.
module purge
module load gcc/11 cmake

JULIA_VERSION="1.8.5"
JULIA_APPLDIR="/appl/soft/math/julia"

# Fail if the Julia directory already exists.
[ -d "$JULIA_APPLDIR/julia-${JULIA_VERSION}" ] && exit 1

# Extract the source code
tar xf "$JULIA_APPLDIR/julia-${JULIA_VERSION}.tar.gz" --directory "$JULIA_APPLDIR"

# Set the number of cores to use for compilation.
# Don't use all cores on the login node!
NUM_CORES=12

# Build Julia using gcc with some optimizations.
# If the some dependencies can't be downloaded , they can be added manually.
# Most problems fixed by running `make` again or `make clean && make`.
export CC=gcc
export CFLAGS="-O2 -march=native"
(
    cd "$JULIA_APPLDIR/julia-${JULIA_VERSION}" && \
    make -j "$NUM_CORES"
)
