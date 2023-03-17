using ArgParse
s = ArgParseSettings()
@add_arg_table s begin
    "-n"
        help = "size of the matrix"
        arg_type = Int
        default = 1_000
    "--mkl"
        help = "use MKL"
        action = :store_true
end
args = parse_args(s)

if args["mkl"]
    using MKL
end
using LinearAlgebra
using BenchmarkTools

@show BLAS.get_config()
n = args["n"]
A = rand(Float64, (n, n))
for threads in [1, 2, 4, 10, 20, 40]
    BLAS.set_num_threads(threads)
    @show BLAS.get_num_threads()
    @btime $A * $A
end
