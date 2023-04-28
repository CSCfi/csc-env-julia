local JULIA_APPLDIR = "/appl/soft/math/julia"
local JULIA_CSC_DEPOT = pathJoin(JULIA_APPLDIR, "depot")

-- Module dependecies for installing packages.
depends_on("julia/1.8.5")

-- We use the default load path by unsetting the environment variable.
unsetenv("JULIA_LOAD_PATH")

-- Directory for the shared packages and other depots.
setenv("JULIA_DEPOT_PATH", JULIA_CSC_DEPOT)

-- Directory for the shared environment.
setenv("JULIA_PROJECT", pathJoin(JULIA_CSC_DEPOT, "environments/v1.8_shared"))

-- Disable history when installing shared packages.
setenv("JULIA_HISTORY", "/dev/null")

-- Diretory for the Julia kernel
setenv("JUPYTER_DATA_DIR", pathJoin(JULIA_APPLDIR, "jupyter"))
