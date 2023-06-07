help("Environment for using AMDGPU.jl with the Julia language.")

depends_on("julia/1.9.0", "PrgEnv-cray-amd", "rocm/5.2")

-- Use local ROCm installation for AMDGPU.jl.
setenv("JULIA_AMDGPU_DISABLE_ARTIFACTS", "1")
