using Random
using BenchmarkTools
using CUDA

Random.seed!(802365)

A = rand(10_000, 10_000)
@btime $A * $A

A_d = CuArray(A)
@btime $A_d * $A_d
