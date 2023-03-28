help([[
Julia kernel for Jupyter.
]])

local JUPYTER_BIN = "/appl/soft/math/julia/jupyter-env/bin"

depends_on("julia/1.8.5")

-- We append the Jupyter bin so that we use it only if jupyter is not already on the path.
append_path("PATH", JUPYTER_BIN)
