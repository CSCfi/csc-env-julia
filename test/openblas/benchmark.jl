using ArgParse
using LinearAlgebra
using BenchmarkTools

s = ArgParseSettings()
@add_arg_table s begin
    "-n"
        help = "size of the matrix"
        arg_type = Int
        default = 1_000
    "-t"
        help = "number of threads"
        arg_type = Int
        default = 1
end
args = parse_args(s)
n = args["n"]
t = args["t"]

BLAS.set_num_threads(t)
@show BLAS.get_config()
@show BLAS.get_num_threads()

A = rand(Float64, (n, n))
@btime $A * $A
