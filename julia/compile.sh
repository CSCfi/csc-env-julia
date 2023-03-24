#!/usr/bin/env sh
set -eu

# Set the number of cores to use for compilation.
# Don't use all cores on the login node!
NUM_CORES=12

# Julia version to install
JULIA_VERSION="1.8.5"

# Fail if the Julia directory already exists.
[ -d "julia-${JULIA_VERSION}" ] && exit 1

# Extract the source code
tar -xzf "julia-${JULIA_VERSION}.tar.gz"

# Setup the environment for the installation.
# Devdocs containers The full list of requirements.
# https://github.com/JuliaLang/julia/blob/master/doc/src/devdocs/build/build.md
module purge
module load gcc cmake make python-data

# Build Julia using gcc with some optimizations.
# If the some dependencies can't be downloaded , they can be added manually.
# Most problems fixed by running `make` again or `make clean && make`.
export CFLAGS="-O2 -march=native"
(cd "julia-${JULIA_VERSION}" && make -j "$NUM_CORES")
