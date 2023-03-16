using Test
using CUDA

println(CUDA.versioninfo())

n = 2^20
x = CUDA.fill(1.0f0, n)
y = CUDA.fill(2.0f0, n)
y .+= x
@test all(Array(y) .== 3.0f0)
println("CUDA works")
