help([[
Private Jupyter Notebook and Lab for Julia on Open OnDemand.
]])

-- Set path to Jupyter
local JULIA_APPLDIR = "/appl/soft/math/julia"
prepend_path("PATH", pathJoin(JULIA_APPLDIR, "jupyter-env/bin"))

-- Prepend the location of Julia kernels to path so that Jupyter will find them.
prepend_path("JUPYTER_PATH", pathJoin(JULIA_APPLDIR, "jupyter"))

-- Load Julia
depends_on("julia/1.8.5")
