help([[
Jupyter Notebook and Jupyter Lab, and Julia kernels for them.
]])

local JULIA_APPLDIR = "/appl/local/csc/soft/math/julia"

-- Set path to Python virtual env containing Jupyter.
prepend_path("PATH", pathJoin(JULIA_APPLDIR, "jupyter-env/bin"))

-- Set path to Julia kernels so that Jupyter can find them.
-- Separate from `jupyter-env` so that it is possible to use other Jupyter
-- installations if needed.
prepend_path("JUPYTER_PATH", pathJoin(JULIA_APPLDIR, "jupyter"))
