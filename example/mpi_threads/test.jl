using MPI
using Random
using Base.Threads

MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)

function sqrt_array!(a, b)
    @threads for i in eachindex(a)
        @inbounds b[i] = sqrt(a[i])
    end
end

@show nthreads()
Random.seed!(802365 + rank)
n = 1000
a = rand(n)
b = zeros(n)
sqrt_array!(a, b)

println("Hello from process $(rank) out of $(size)")
MPI.Barrier(comm)
