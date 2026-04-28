#!/usr/bin/env bash
module load julia
module load gcc
module load openmpi
module load hdf5/1.10.7-mpi
julia --project=. setup.jl
