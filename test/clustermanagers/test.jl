using Distributed
using ClusterManagers

n = parse(Int, ENV["SLURM_NTASKS"])
addprocs(SlurmManager(n), topology=:master_worker)
task(i) = @spawnat i (myid(), gethostname(), getpid())
@show futures = [task(i) for i in workers()]
@show outputs = fetch.(futures)

# The Slurm resource allocation is released when all the workers have exited
rmprocs.(workers())
