help([[Environment for using CUDA.jl with the Julia language.]])

depends_on("cuda/11.5")

-- Disable memory pool for CUDA.jl
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
