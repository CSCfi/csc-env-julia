using Pkg
Pkg.add(name="CUDA", version="4.0.1")
Pkg.add(name="MPI", version="0.20.8")
Pkg.add(name="MPIPreferences")
Pkg.add(name="ClusterManagers")

using CUDA
CUDA.set_runtime_version!("local")

using MPIPreferences
MPIPreferences.use_system_binary()

Pkg.instantiate()
