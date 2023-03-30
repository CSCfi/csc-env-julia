help([[
Julia language and dependencies.
]])

local JULIA_APPLDIR = "/appl/soft/math/julia"
local JULIA_VERSION = "1.9.0-rc1"
local JULIA_DIR = pathJoin(JULIA_APPLDIR, "julia-" .. JULIA_VERSION)

-- Dependencies for Julia and shared packages.
-- MPI.jl depends on Open MPI
-- CUDA.jl depends on CUDA.
depends_on("gcc/11", "openmpi/4", "cuda/11")

-- Path to the Julia library files.
prepend_path("LD_LIBRARY_PATH", pathJoin(JULIA_DIR, "lib"))

-- Path to the Julia binary.
prepend_path("PATH", pathJoin(JULIA_DIR, "bin"))

-- Path to the Julia man pages.
prepend_path("MANPATH", pathJoin(JULIA_DIR, "share/man"))

-- We set the depot path explicitly such that it is easier to modify.
-- https://docs.julialang.org/en/v1/base/constants/#Base.DEPOT_PATH
append_path("JULIA_DEPOT_PATH", pathJoin(os.getenv("HOME"), ".julia"))
append_path("JULIA_DEPOT_PATH", pathJoin(JULIA_APPLDIR, "depot"))
append_path("JULIA_DEPOT_PATH", pathJoin(JULIA_DIR, "share/julia"))

-- We set load path explicitly such that it is easier to modify.
-- https://docs.julialang.org/en/v1/base/constants/#Base.LOAD_PATH
append_path("JULIA_LOAD_PATH", "@")
append_path("JULIA_LOAD_PATH", "@v#.#")
append_path("JULIA_LOAD_PATH", "@stdlib")
append_path("JULIA_LOAD_PATH", pathJoin(JULIA_APPLDIR, "depot/environments/v1.9_shared"))

-- Disable memory pool for CUDA.jl
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")

-- Prepend Julia kernel location to Jupyter path so that Jupyter will find it.
--prepend_path("JUPYTER_PATH", pathJoin(JULIA_APPLDIR, "jupyter"))
