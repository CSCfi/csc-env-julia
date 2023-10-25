using Pkg
Pkg.add(name="CUDA", version="4.4.1")
Pkg.pin("CUDA")

using CUDA
CUDA.set_runtime_version!("local")
