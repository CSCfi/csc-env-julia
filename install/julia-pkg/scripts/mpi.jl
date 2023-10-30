using Pkg
Pkg.add(name="MPI", version="0.20.8")
Pkg.pin("MPI")
Pkg.add(name="MPIPreferences")
Pkg.pin("MPIPreferences")

using MPIPreferences
MPIPreferences.use_system_binary(; mpiexec="srun")
