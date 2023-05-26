help([[
Julia language and dependencies.
]])

-- Version in the semantic version format "x.y.z-rc"
local JULIA_VERSION = myModuleVersion()
local JULIA_VERSION_MAJOR, JULIA_VERSION_MINOR = JULIA_VERSION:match("(%d+)%.(%d+)")

-- Directories
local JULIA_APPL_DIR = "/appl/local/csc/soft/math/julia"
local JULIA_RELEASE_DIR = pathJoin(JULIA_APPL_DIR, "julia-" .. JULIA_VERSION)
local JULIA_DEPOT_DIR = pathJoin(JULIA_APPL_DIR, "depot")
local JULIA_ENVIRONMENT_DIR = pathJoin(JULIA_DEPOT_DIR, "environments/v" .. JULIA_VERSION_MAJOR .. "." .. JULIA_VERSION_MINOR .. "_shared")

-- Load dependencies for Julia, MPI, GPUs and shared packages.
depends_on("PrgEnv-cray-amd", "rocm/5.2")

-- Set Julia application directory to environment
setenv("CSC_JULIA_APPL_DIR", JULIA_APPL_DIR)

-- Path to the Julia library files.
--prepend_path("LD_LIBRARY_PATH", pathJoin(JULIA_RELEASE_DIR, "lib"))

-- Path to the Julia binary.
prepend_path("PATH", pathJoin(JULIA_RELEASE_DIR, "bin"))

-- Path to the Julia man pages.
prepend_path("MANPATH", pathJoin(JULIA_RELEASE_DIR, "share/man"))

-- We set the depot path explicitly such that it is easier to modify.
-- https://docs.julialang.org/en/v1/base/constants/#Base.DEPOT_PATH
append_path("JULIA_DEPOT_PATH", pathJoin(os.getenv("HOME"), ".julia"))
append_path("JULIA_DEPOT_PATH", JULIA_DEPOT_DIR)
append_path("JULIA_DEPOT_PATH", pathJoin(JULIA_RELEASE_DIR, "share/julia"))
setenv("CSC_JULIA_DEPOT_DIR", JULIA_DEPOT_DIR)

-- We set load path explicitly such that it is easier to modify.
-- https://docs.julialang.org/en/v1/base/constants/#Base.LOAD_PATH
append_path("JULIA_LOAD_PATH", "@")
append_path("JULIA_LOAD_PATH", "@v#.#")
append_path("JULIA_LOAD_PATH", "@stdlib")
append_path("JULIA_LOAD_PATH", JULIA_ENVIRONMENT_DIR)
setenv("CSC_JULIA_ENVIRONMENT_DIR", JULIA_ENVIRONMENT_DIR)

-- Set Julia's thread count based on Slurm's `--cpus-per-task` value.
-- Default to 1 if no value is set.
-- https://docs.julialang.org/en/v1/manual/environment-variables/#Parallelization
local NUM_THREADS = os.getenv("SLURM_CPUS_PER_TASK") or "1"
setenv("JULIA_CPU_THREADS", NUM_THREADS)
setenv("JULIA_NUM_THREADS", NUM_THREADS)

-- We set OpenBLAS and MKL thread counts to the number of available threads by default.
setenv("OPENBLAS_NUM_THREADS", NUM_THREADS)
setenv("MKL_NUM_THREADS", NUM_THREADS)

-- Use local ROCm installation for AMDGPU.jl.
setenv("JULIA_AMDGPU_DISABLE_ARTIFACTS", "1")
