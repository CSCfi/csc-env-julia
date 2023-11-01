using Pkg
Pkg.activate(; temp=true)
Pkg.add("https://github.com/JuliaParallel/MPIBenchmarks.jl")

using MPIBenchmarks

const job_id = get(ENV, "SLURM_JOB_ID", "0")
mkpath("mpi_benchmarks_$job_id")
cd("mpi_benchmarks_$job_id")

# Collective benchmarks
benchmark(IMBAllreduce())
benchmark(IMBAlltoall())
benchmark(IMBGatherv())
benchmark(IMBReduce())
benchmark(OSUAllreduce())
benchmark(OSUAlltoall())
benchmark(OSUReduce())

# Point-to-point benchmarks.
# NOTE: they require exactly two MPI processes.
benchmark(IMBPingPong())
benchmark(IMBPingPing())
benchmark(OSULatency())
