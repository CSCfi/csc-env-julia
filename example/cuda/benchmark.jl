using Random
using BenchmarkTools
using CUDA

@show CUDA.versioninfo()

Random.seed!(802365)

A = rand(10_000, 10_000)
A_d = CuArray(A)
@btime $A_d * $A_d
