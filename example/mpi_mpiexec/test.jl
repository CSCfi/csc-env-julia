using MPI
mpiexec(mpirun -> run(`$mpirun julia --project=. prog.jl`))
