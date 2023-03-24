using Distributed

n = parse(Int, ENV["SLURM_NTASKS_PER_NODE"])
addprocs(n)
@everywhere task() = (myid(), gethostname(), getpid())
futures = [@spawnat i task() for i in workers()]
@show task()
@show outputs = fetch.(futures)

# The Slurm resource allocation is released when all the workers have exited
rmprocs.(workers())
