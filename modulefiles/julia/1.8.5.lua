help([[
Julia language and dependencies.
]])

local JULIA_APPLDIR = "/appl/soft/math/julia"
local JULIA_VERSION = "1.8.5"
local JULIA_DIR = pathJoin(JULIA_APPLDIR, "julia-" .. JULIA_VERSION)
local HOME = os.getenv("HOME")

depends_on("gcc/11", "openmpi/4", "cuda/11")

prepend_path("LD_LIBRARY_PATH", pathJoin(JULIA_DIR, "usr/lib"))
prepend_path("PATH", pathJoin(JULIA_DIR, "usr/bin"))
prepend_path("MANPATH", pathJoin(JULIA_DIR, "usr/share/man"))

append_path("JULIA_DEPOT_PATH", pathJoin(HOME, ".julia"))
append_path("JULIA_DEPOT_PATH", pathJoin(JULIA_APPLDIR, "depot"))
append_path("JULIA_DEPOT_PATH", pathJoin(JULIA_DIR, "usr/share/julia"))

append_path("JULIA_LOAD_PATH", "@")
append_path("JULIA_LOAD_PATH", "@v#.#")
append_path("JULIA_LOAD_PATH", "@stdlib")
append_path("JULIA_LOAD_PATH", pathJoin(JULIA_APPLDIR, "depot/environments/v1.8_shared"))

setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
