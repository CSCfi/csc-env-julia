using Distributed

# TODO: parse from nodes from ENV["SLURM_JOB_NODELIST"]
# TODO: add processes on the local node with LocalManager
# TODO: add processes on the other nodes with SSHManager
addprocs(Sys.CPU_THREADS)
addprocs([("r07c06.bullx", Sys.CPU_THREADS)]; tunnel=true)
#addprocs([("r07c05.bullx", Sys.CPU_THREADS), ("r07c06.bullx", Sys.CPU_THREADS)]; tunnel=true)

@everywhere function task()
    return (myid(), gethostname(), getpid())
end

futures = [@spawnat i task() for i in workers()]
outputs = fetch.(futures)

println("task:", task())
println.("outputs: ", outputs)

rmprocs.(workers())
