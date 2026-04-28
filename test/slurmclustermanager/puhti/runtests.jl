using Test
using Distributed
using SlurmClusterManager

const cpus_per_task = get(ENV, "SLURM_CPUS_PER_TASK", "1")

manager = SlurmManager()
ps = addprocs(manager; exeflags="--threads=$cpus_per_task")

tasks = map(ps) do worker
    @spawnat worker (myid(), gethostname(), Threads.nthreads())
end

rs = fetch.(tasks)
for (worker, r) in zip(ps, rs)
    println(r)
    @test r[1] == worker
    @test string(r[3]) == cpus_per_task
end

@test remotecall_fetch(+, ps[1], 1, 1) == 2

rmprocs(ps)
@test nprocs() == 1
@test workers() == [1]
