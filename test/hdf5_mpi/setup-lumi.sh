#!/bin/bash
module use /appl/local/csc/modulefiles
module load julia
module load cray-hdf5-parallel
julia --project=. setup.jl
