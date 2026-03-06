using Distributed

const cpus_per_task = parse(Int, get(ENV, "SLURM_CPUS_PER_TASK", "1"))
addprocs(cpus_per_task - 1)

@everywhere function task(cmd)
    return (read(cmd, String), myid())
end

cmds = [`echo $i` for i in 1:100]
futures = [@spawnat :any task(cmd) for cmd in cmds]
results = [fetch(future) for future in futures]
println(results)
