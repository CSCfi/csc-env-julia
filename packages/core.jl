using Pkg
Pkg.add(name="MKL", version="0.6.0")
Pkg.add(name="CUDA", version="4.0.1")
Pkg.add(name="MPI", version="0.20.8")
Pkg.add(name="MPIPreferences")

using CUDA
CUDA.set_runtime_version!("local")

using MPIPreferences
MPIPrererences.use_system_binary()

Pkg.instantiate()
