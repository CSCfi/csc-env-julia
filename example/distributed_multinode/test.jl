using Distributed

# Read the list of nodenames allocated by Slurm.
nodes = readlines(`scontrol show hostnames $(ENV["SLURM_JOB_NODELIST"])`)

# Retrieve the node name of the master process.
local_node = gethostname()

# Environment variable that we pass to the worker processes.
proc_env = ["JULIA_NUM_THREADS"=>"1", "JULIA_CPU_THREADS"=>"1"]

# Add processes on the local node with LocalManager.
addprocs(Sys.CPU_THREADS;
         env=proc_env,
         enable_threaded_blas=false)

# Add processes on the other nodes with SSHManager.
addprocs([(node, Sys.CPU_THREADS) for node in nodes if node != local_node];
         tunnel=true,
         env=proc_env,
         enable_threaded_blas=false)

@everywhere function task()
    (
        id=myid(),
        hostname=gethostname(),
        pid=getpid(),
        nthreads=Base.Threads.nthreads(),
        cputhreads=Sys.CPU_THREADS
    )
end

futures = [@spawnat i task() for i in workers()]
outputs = fetch.(futures)

println("master")
println(task())

println("workers")
println.(outputs)

rmprocs.(workers())
