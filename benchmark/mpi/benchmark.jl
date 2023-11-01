using Pkg
Pkg.activate(; temp=true)
Pkg.add("https://github.com/JuliaParallel/MPIBenchmarks.jl")

using MPIBenchmarks

mkpath("output")
cd("output")

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
