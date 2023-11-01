using Test
using Distributed
using ClusterManagers

# SLURM_NTASKS = SLURM_NNODES * SLURM_NTASKS_PER_NODE
const ntasks = parse(Int, ENV["SLURM_NTASKS"])
const cpus_per_task = get(ENV, "SLURM_CPUS_PER_TASK", "1")

manager = SlurmManager(ntasks)
ps = addprocs(manager; exeflags="--threads=$cpus_per_task")

@test nprocs() == ntasks + 1
@test workers() == ps

tasks = map(ps) do worker
    @spawnat worker (myid(), gethostname(), Threads.nthreads())
end

rs = fetch.(tasks)
for (worker, r) in zip(ps, rs)
    println(r)
    @test r[1] == worker
    @test r[3] == cpus_per_task
end

@test remotecall_fetch(+,ps[1],1,1) == 2

rmprocs(ps)
@test nprocs() == 1
@test workers() == [1]
