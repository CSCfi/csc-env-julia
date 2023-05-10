using ArgParse
using LinearAlgebra
using BenchmarkTools

s = ArgParseSettings()
@add_arg_table s begin
    "-n"
        help = "size of the matrix"
        arg_type = Int
        default = 1_000
end
args = parse_args(s)
n = args["n"]

BLAS.set_num_threads(Sys.CPU_THREADS)
@show BLAS.get_config()
@show BLAS.get_num_threads()
@show Base.Threads.nthreads()

A = rand(Float64, (n, n))
@btime $A * $A
