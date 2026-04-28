#!/usr/bin/env bash
module load julia
module load julia-mpi
module load gcc
module load openmpi
module load hdf5
export HDF5_DIR=$HDF5_INSTALL_ROOT
julia --project=. setup.jl
