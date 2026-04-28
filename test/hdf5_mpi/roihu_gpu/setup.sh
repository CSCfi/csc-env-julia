#!/usr/bin/env bash
module purge
module load gcc/14.3
module load julia
module load julia-mpi
module load openmpi
module load hdf5
export HDF5_DIR=$HDF5_INSTALL_ROOT
julia --project=. setup.jl
