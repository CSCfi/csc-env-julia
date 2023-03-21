using MPI

function pingpong(T, bufsize, iters)
    buffer = zeros(T, bufsize)
    comm = MPI.COMM_WORLD
    rank = MPI.Comm_rank(comm)
    tag = 0

    MPI.Barrier(comm)
    tic = MPI.Wtime()
    for i = 1:iters
        if rank == 0
            MPI.Send(buffer, 1, tag, comm)
            MPI.Recv!(buffer, 1, tag, comm)
        else
            MPI.Recv!(buffer, 0, tag, comm)
            MPI.Send(buffer, 0, tag, comm)
        end
    end
    toc = MPI.Wtime()

    avgtime = (toc-tic)/iters
    return avgtime
end

MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)

# perform a warmup iteration to avoid measuring compilation time
pingpong(Float64, 10, 2)

for i = 1:6
    t = pingpong(Float64, 10^i, 10000)
    if rank == 0
        println("10^$(i), $(t)")
    end
end

