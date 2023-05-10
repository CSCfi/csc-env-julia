using Pkg
Pkg.add(name="CUDA", version="4.0.1")
Pkg.pin("CUDA")

using CUDA
CUDA.set_runtime_version!("local")
