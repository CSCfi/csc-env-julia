using Distributed
using ClusterManagers

# Same as: SLURM_NNODES * SLURM_NTASKS_PER_NODE
ntasks = parse(Int, ENV["SLURM_NTASKS"])
cpus_per_task = get(ENV, "SLURM_CPUS_PER_TASK", "1")
manager = SlurmManager(ntasks)
addprocs(manager; exeflags="--threads=$cpus_per_task")

tasks = map(workers()) do worker
    @spawnat worker (myid(), gethostname(), Threads.nthreads())
end

println(fetch.(tasks))

foreach(rmprocs, workers())
