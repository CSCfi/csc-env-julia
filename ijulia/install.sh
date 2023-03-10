#!/usr/bin/env bash
set -eu

# Load Julia
module purge
module load julia/1.8.5

# Directory for shared Julia depots
export JULIA_DEPOT_PATH="/appl/soft/math/julia/depot"

# Shared IJulia environment
export JULIA_PROJECT="/appl/soft/math/julia/depot/environments/v1.8_ijulia"

# Directory for the jupyter kernel
export JUPYTER_DATA_DIR="/appl/soft/math/julia/jupyter-env/share/jupyter"

# Jupyter executable name
export JUPYTER="jupyter"

# Install IJulia
julia -e 'using Pkg; Pkg.add(name="IJulia", version="1.24.0")'

# Replace the default kernel with a custom kernel
cp kernel.json "$JUPYTER_DATA_DIR/kernels/julia-1.8/kernel.json"
