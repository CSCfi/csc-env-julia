depends_on("gcc/11", "cuda/11", "openmpi/4.1.4-cuda", "julia/1.8.5")
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
