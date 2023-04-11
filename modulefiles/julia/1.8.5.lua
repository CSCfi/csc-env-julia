help([[
Julia language and dependencies.
]])

local JULIA_APPLDIR = "/appl/soft/math/julia"
local JULIA_VERSION = "1.8.5"
local JULIA_DIR = pathJoin(JULIA_APPLDIR, "julia-" .. JULIA_VERSION)

-- Dependencies for Julia and shared packages.
-- MPI.jl depends on Open MPI
-- CUDA.jl depends on CUDA.
depends_on("gcc/11", "openmpi/4", "cuda/11")

-- Path to the Julia library files.
prepend_path("LD_LIBRARY_PATH", pathJoin(JULIA_DIR, "usr/lib"))

-- Path to the Julia binary.
prepend_path("PATH", pathJoin(JULIA_DIR, "usr/bin"))

-- Path to the Julia man pages.
prepend_path("MANPATH", pathJoin(JULIA_DIR, "usr/share/man"))

-- We set the depot path explicitly such that it is easier to modify.
-- https://docs.julialang.org/en/v1/base/constants/#Base.DEPOT_PATH
append_path("JULIA_DEPOT_PATH", pathJoin(os.getenv("HOME"), ".julia"))
append_path("JULIA_DEPOT_PATH", pathJoin(JULIA_APPLDIR, "depot"))
append_path("JULIA_DEPOT_PATH", pathJoin(JULIA_DIR, "usr/share/julia"))

-- We set load path explicitly such that it is easier to modify.
-- https://docs.julialang.org/en/v1/base/constants/#Base.LOAD_PATH
append_path("JULIA_LOAD_PATH", "@")
append_path("JULIA_LOAD_PATH", "@v#.#")
append_path("JULIA_LOAD_PATH", "@stdlib")
append_path("JULIA_LOAD_PATH", pathJoin(JULIA_APPLDIR, "depot/environments/v1.8_shared"))

-- Set Julia's thread count based on the Slurm allocation.
local NUM_THREADS = os.getenv("SLURM_CPUS_PER_TASK")
if NUM_THREADS ~= nil then
    setenv("JULIA_CPU_THREADS", NUM_THREADS)
    setenv("JULIA_NUM_THREADS", NUM_THREADS)
end

-- Disable memory pool for CUDA.jl
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
