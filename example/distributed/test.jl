using Distributed

n = parse(Int, ENV["SLURM_NTASKS_PER_NODE"]) - 1
addprocs(n)

@everywhere task() = (myid(), gethostname(), getpid())
futures = [@spawnat i task() for i in workers()]
outputs = fetch.(futures)

println(task())
println.(outputs)

rmprocs.(workers())
