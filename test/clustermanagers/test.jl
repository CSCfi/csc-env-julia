using Distributed
using ClusterManagers

addprocs(SlurmManager(2), nodes="1")
futures = [@spawnat(i (gethostname(), getpid())) for i in workers()]
outputs = fetch.(futures)
@show outputs

# The Slurm resource allocation is released when all the workers have exited
rmprocs.(workers())
