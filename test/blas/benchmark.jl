using ArgParse
s = ArgParseSettings()
@add_arg_table s begin
    "-n"
        help = "size of the matrix"
        arg_type = Int
        default = 1000
    "--mkl"
        help = "use MKL"
        action = :store_true
end
args = parse_args(s)

if args["mkl"]
    using MKL
end
using Base.Threads
using LinearAlgebra
using BenchmarkTools

BLAS.set_num_threads(nthreads())
println(BLAS.get_config())

n = args["n"]
A = rand(Float64, (n, n))
@btime $A * $A
