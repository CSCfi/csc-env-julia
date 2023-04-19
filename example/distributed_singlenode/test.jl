using Distributed

addprocs(Sys.CPU_THREADS)

@everywhere function task()
    return (myid(), gethostname(), getpid())
end

futures = [@spawnat i task() for i in workers()]
outputs = fetch.(futures)

println(task())
println.(outputs)

rmprocs.(workers())
