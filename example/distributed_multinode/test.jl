using Distributed

# TODO: parse from ENV["SLURM_JOB_NODELIST"]
addprocs([("r07c05.bullx", Sys.CPU_THREADS), ("r07c06.bullx", Sys.CPU_THREADS)]; tunnel=true)

@everywhere function task()
    return (myid(), gethostname(), getpid())
end

futures = [@spawnat i task() for i in workers()]
outputs = fetch.(futures)

println("nprocs: ", nprocs())
println("task:", task())
println.("outputs: ", outputs)

rmprocs.(workers())
