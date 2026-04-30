#!/usr/bin/env bash
module purge
module load gcc/14.3
module load julia
module load julia-mpi
module load hdf5
julia --project=. setup.jl
