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
local JULIA_CSC_DEPOT = pathJoin(JULIA_APPLDIR, "depot")
append_path("JULIA_DEPOT_PATH", pathJoin(os.getenv("HOME"), ".julia"))
append_path("JULIA_DEPOT_PATH", JULIA_CSC_DEPOT)
append_path("JULIA_DEPOT_PATH", pathJoin(JULIA_DIR, "usr/share/julia"))
setenv("JULIA_CSC_DEPOT", JULIA_CSC_DEPOT)

-- We set load path explicitly such that it is easier to modify.
-- https://docs.julialang.org/en/v1/base/constants/#Base.LOAD_PATH
local JULIA_CSC_ENVIRONMENT = pathJoin(JULIA_CSC_DEPOT, "environments/v1.8_shared")
append_path("JULIA_LOAD_PATH", "@")
append_path("JULIA_LOAD_PATH", "@v#.#")
append_path("JULIA_LOAD_PATH", "@stdlib")
append_path("JULIA_LOAD_PATH", JULIA_CSC_ENVIRONMENT)
setenv("JULIA_CSC_ENVIRONMENT", JULIA_CSC_ENVIRONMENT)

-- Set Julia's thread count based on Slurm's `--cpus-per-task` value.
-- Default to 1 if no value is set.
-- https://docs.julialang.org/en/v1/manual/environment-variables/#Parallelization
local NUM_THREADS = os.getenv("SLURM_CPUS_PER_TASK") or "1"
setenv("JULIA_CPU_THREADS", NUM_THREADS)
setenv("JULIA_NUM_THREADS", NUM_THREADS)

-- https://carstenbauer.github.io/ThreadPinning.jl/dev/explanations/blas/
-- We set OpenBLAS and MKL threads to one so that their thread count is
-- controlled by JULIA_NUM_THREADS.
setenv("OPENBLAS_NUM_THREADS", "1")
setenv("MKL_NUM_THREADS", "1")

-- Disable memory pool for CUDA.jl
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
