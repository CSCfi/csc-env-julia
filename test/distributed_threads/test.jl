using Distributed
@everywhere using Base.Threads

n = parse(Int, ENV["SLURM_NTASKS_PER_NODE"]) - 1
addprocs(n)

@everywhere function task()
    n = Threads.nthreads()
    ids = zeros(Int, n)
    Threads.@threads for i in 1:n
        sleep(1)
        ids[i] = Threads.threadid()
    end
    return (ids, myid(), gethostname(), getpid())
end

futures = [@spawnat i task() for i in workers()]
outputs = fetch.(futures)

println(task())
println.(outputs)

# The Slurm resource allocation is released when all the workers have exited
rmprocs.(workers())
