using Distributed

n = parse(Int, ENV["SLURM_NTASKS_PER_NODE"])
addprocs(n)
task(i) = @spawnat i (myid(), gethostname(), getpid())
futures = [task(i) for i in workers()]
@show myid()
@show outputs = fetch.(futures)

# The Slurm resource allocation is released when all the workers have exited
rmprocs.(workers())
