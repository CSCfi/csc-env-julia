help([[
Julia language and dependencies.
]])

local JULIA_VERSION = "1.8.5"
local JULIA_DIR = "/appl/soft/math/julia/julia-" .. JULIA_VERSION
local JULIA_DEPOT_PATH = ":/appl/soft/math/julia/depot"
local JULIA_LOAD_PATH = ":/appl/soft/math/julia/depot/environments/v1.8_shared"
local JULIA_BINDIR = pathJoin(JULIA_DIR, "usr/bin")
local JULIA_LIBDIR = pathJoin(JULIA_DIR, "usr/lib")
local JULIA_MANDIR = pathJoin(JULIA_DIR, "usr/share/man")

depends_on("gcc/11", "openmpi/4", "cuda/11")
prepend_path("LD_LIBRARY_PATH", JULIA_LIBDIR)
prepend_path("PATH", JULIA_BINDIR)
prepend_path("MANPATH", JULIA_MANDIR)
setenv("JULIA_DEPOT_PATH", (os.getenv("JULIA_DEPOT_PATH") or "") .. JULIA_DEPOT_PATH)
setenv("JULIA_LOAD_PATH", (os.getenv("JULIA_LOAD_PATH") or "") .. JULIA_LOAD_PATH)
setenv("JULIA_CUDA_USE_MEMORY_POOL", "none")
