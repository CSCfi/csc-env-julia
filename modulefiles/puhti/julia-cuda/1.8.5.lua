depends_on("julia/1.8.5", "cuda")

-- Disable memory pool for CUDA.jl
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
