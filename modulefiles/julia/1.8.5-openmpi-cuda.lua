depends_on("gcc/11.3.0", "openmpi/4.1.4-cuda", "cuda/11.7.0", "julia/1.8.5")
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
