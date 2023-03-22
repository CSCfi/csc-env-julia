help([[
Julia kernel for Jupyter.
]])

local JUPYTER_BIN = "/appl/soft/math/julia/jupyter-env/bin"

depends_on("julia/1.8.5")
prepend_path("PATH", JUPYTER_BIN)
