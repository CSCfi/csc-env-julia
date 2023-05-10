using Distributed

# We set one worker process per node.
proc_num = 1

# Environment variables that we pass to the worker processes.
# We set the thread count to CPU_THREADS such that each worker uses all reserved cores in the node.
proc_env = [
    "JULIA_NUM_THREADS"=>"$(Sys.CPU_THREADS)",
    "JULIA_CPU_THREADS"=>"$(Sys.CPU_THREADS)",
    "OPENBLAS_NUM_THREADS"=>"$(Sys.CPU_THREADS)",
    "MKL_NUM_THREADS"=>"$(Sys.CPU_THREADS)",
]

# Read the list of nodenames allocated by Slurm.
nodes = readlines(`scontrol show hostnames $(ENV["SLURM_JOB_NODELIST"])`)

# Retrieve the node name of the master process.
local_node = first(split(gethostname(), '.'))

# We add worker processes to the local node using LocalManager.
addprocs(proc_num;
         env=proc_env,
         enable_threaded_blas=true,
         exeflags="--project=.")

# We add worker processes to the other nodes with SSHManager.
addprocs([(node, proc_num) for node in nodes if node != local_node];
         tunnel=true,
         env=proc_env,
         exeflags="--project=.",
         enable_threaded_blas=true)

println(workers())

# We use the `@everywhere` macro to include the task function in the worker processes.
# We must call `@everwhere` after adding worker processes; otherwise the code won't be included in the new processes.

@everywhere using Base.Threads

@everywhere function task_threads()
    ids = zeros(Int, 2*nthreads())
    @threads for i in eachindex(ids)
        ids[i] = threadid()
    end
    return ids
end

@everywhere function task()
    (
        id=myid(),
        hostname=gethostname(),
        pid=getpid(),
        nthreads=nthreads(),
        cputhreads=Sys.CPU_THREADS,
        thread_ids=task_threads()
    )
end

# We run the task function in each worker process.
futures = [@spawnat id task() for id in workers()]

# Then, we fetch the output from the processes.
outputs = fetch.(futures)

# Remove processes after we are done.
rmprocs.(workers())

# Print the outputs of master and worker processes.
#println("master")
#println(task())
println("workers")
println.(outputs)
