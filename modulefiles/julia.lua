help([[
Julia language and dependencies.
]])

depends_on("StdEnv")

local JULIA_VERSION = "1.8.5"
local JULIA_DIR = "/appl/soft/math/julia/julia-" .. JULIA_VERSION
local JULIA_DEPOT_PATH = ":/appl/soft/math/julia/depot"
local JULIA_LOAD_PATH = ":/appl/soft/math/julia/depot/environments/v1.8_shared"
local APPLDIR = pathJoin(JULIA_DIR, "usr/bin")
local LIBDIR = pathJoin(JULIA_DIR, "usr/lib")
local MANDIR = pathJoin(JULIA_DIR, "usr/share/man")

prepend_path("LD_LIBRARY_PATH", LIBDIR)
prepend_path("PATH", APPLDIR)
prepend_path("MANPATH", MANDIR)
setenv("JULIA_DEPOT_PATH", (os.getenv("JULIA_DEPOT_PATH") or "") .. JULIA_DEPOT_PATH)
setenv("JULIA_LOAD_PATH", (os.getenv("JULIA_LOAD_PATH") or "") .. JULIA_LOAD_PATH)

if (mode() == "load") then
    LmodMessage("julia", JULIA_VERSION, "loaded")
end
