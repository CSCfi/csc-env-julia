using Distributed
using Base.Threads

n = parse(Int, ENV["SLURM_NTASKS_PER_NODE"])
addprocs(n)

@everywhere function task()
    ids = zeros(nthreads())
    @threads for i in 1:nthreads()
        ids[i] = threadid()
    end
    return (ids, myid(), gethostname(), getpid())
end

futures = [@spawnat i task() for i in workers()]

@show task()
@show outputs = fetch.(futures)

# The Slurm resource allocation is released when all the workers have exited
rmprocs.(workers())
