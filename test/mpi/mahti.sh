#!/bin/bash
#SBATCH --job-name=test_mpi
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=64

export JULIA_MPI_TEST_NPROCS=$SLURM_NTASKS_PER_NODE
export JULIA_MPI_TEST_EXCLUDE="test_errorhandler.jl,test_spawn.jl,test_error.jl"

module load julia/1.8.5
julia --project=. -e 'import Pkg; Pkg.instantiate()'
julia --project=. test.jl
