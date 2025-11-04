#!/bin/bash
module load julia
module load gcc openmpi hdf5/1.10.7-mpi
export HDF5_DIR=$HDF5_INSTALL_ROOT
julia setup.jl
