using Pkg
Pkg.add(name="CUDA", version="5.0.0")
Pkg.pin("CUDA")

using CUDA
CUDA.set_runtime_version!(local_toolkit=true)
#CUDA.set_runtime_version!(v"{{ julia_gpu_version }}", local_toolkit=true)
#CUDA.set_runtime_version!(v"11.4", local_toolkit=true)
#CUDA.set_runtime_version!(v"11.7", local_toolkit=true)
