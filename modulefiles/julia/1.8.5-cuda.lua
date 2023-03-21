depends_on("gcc/11", "cuda/11", "julia/1.8.5")
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
