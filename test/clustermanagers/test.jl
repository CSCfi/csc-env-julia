using Distributed
using ClusterManagers

n = parse(Int, ENV["SLURM_NTASKS"])
addprocs(SlurmManager(n), topology=:master_worker)
task(i) = @spawnat(i (gethostname(), getpid()))
futures = [task(i) for i in workers()]
outputs = fetch.(futures)
@show outputs

# The Slurm resource allocation is released when all the workers have exited
rmprocs.(workers())
