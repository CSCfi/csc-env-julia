using ArgParse
using Random
using BenchmarkTools
using Base.Threads

s = ArgParseSettings()
@add_arg_table s begin
    "-n"
        help = "size"
        arg_type = Int
        default = 1_000_000
end
args = parse_args(s)

function sqrt_array!(a, b)
    @threads for i in eachindex(a)
        @inbounds b[i] = sqrt(a[i])
    end
end

@show nthreads()
Random.seed!(802365)
n = args["n"]
a = rand(n)
b = zeros(n)
@btime sqrt_array!(a, b)
