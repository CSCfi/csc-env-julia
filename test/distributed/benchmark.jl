using ArgParse
using Random
using BenchmarkTools
using Distributed
using SharedArrays

s = ArgParseSettings()
@add_arg_table s begin
    "-n"
        help = "size"
        arg_type = Int
        default = 1_000_000
end
args = parse_args(s)

function sqrt_array!(a::SharedArray, b::SharedArray)
    @sync @distributed for i in eachindex(a)
        @inbounds b[i] = sqrt(a[i])
    end
end

Random.seed!(802365)
n = args["n"]
a = SharedArray(rand(n))
b = SharedArray(zeros(n))
sqrt_array!(a, b)
#@btime sqrt_array!(a, b)
