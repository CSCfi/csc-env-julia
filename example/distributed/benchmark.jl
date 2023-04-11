using Distributed
using BenchmarkTools

# Add processes before @everywhere using macros!
addprocs(Sys.CPU_THREADS)

function sqrt_sum(A)
    s = zero(eltype(A))
    for i in eachindex(A)
        sleep(0.001)
        s += sqrt(A[i])
    end
    return s
end

@everywhere function sqrt_sum_range(A, r)
    s = zero(eltype(A))
    for i in r
        sleep(0.001)
        s += sqrt(A[i])
    end
    return s
end

function sqrt_sum_distributed(A)
    # TODO: can we simplify the partitioning?
    batch = floor(Int, length(A) / nworkers())
    remainder = length(A) % nworkers()
    futures = Array{Future}(undef, nworkers())
    for (i, id) in enumerate(workers())
        if (i-1) < remainder
            start = 1 + (i - 1) * (batch + 1)
            stop = start + batch
        else
            start = 1 + (i - 1) * batch + remainder
            stop = start + batch - 1
        end
        futures[i] = @spawnat id sqrt_sum_range(A, start:stop)
    end
    return sum(fetch.(futures))
end

A = rand(1000)
@btime sqrt_sum_distributed($A)
@btime sqrt_sum($A)
