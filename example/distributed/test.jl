using Distributed

n = parse(Int, ENV["SLURM_CPUS_PER_TASK"]) - 1
addprocs(n)

@everywhere function task()
    return (myid(), gethostname(), getpid())
end

futures = [@spawnat i task() for i in workers()]
outputs = fetch.(futures)

println(task())
println.(outputs)

rmprocs.(workers())
