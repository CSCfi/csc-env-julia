using Pkg
Pkg.add(name="MPI", version="0.20.8")
Pkg.add(name="MPIPreferences")
Pkg.pin("MPI")

using MPIPreferences
MPIPreferences.use_system_binary(; mpiexec="srun")
