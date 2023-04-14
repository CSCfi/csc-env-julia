#!/bin/bash
#SBATCH --job-name=test_mpi
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

export JULIA_MPI_TEST_NPROCS=2
export JULIA_MPI_TEST_EXCLUDE="test_errorhandler.jl,test_spawn.jl,test_error.jl"

module load julia/1.8.5
julia --project=. test.jl
