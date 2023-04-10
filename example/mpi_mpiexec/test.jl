using MPI
mpiexec() do mpirun
    @assert mpirun == `srun`
    run(`$mpirun julia --startup-file=no prog.jl`)
end
