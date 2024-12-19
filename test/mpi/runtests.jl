using Pkg
Pkg.add("MPI")
Pkg.precompile()
ENV["JULIA_MPI_TEST_NPROCS"] = ENV["SLURM_NTASKS"]
ENV["JULIA_MPI_TEST_EXCLUDE"] = "test_errorhandler.jl,test_spawn.jl,test_error.jl"
Pkg.test("MPI")
