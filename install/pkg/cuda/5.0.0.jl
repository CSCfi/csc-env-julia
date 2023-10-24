using Pkg
Pkg.add(name="CUDA", version="5.0.0")
Pkg.pin("CUDA")

using CUDA
CUDA.set_runtime_version!(local_toolkit=true)
