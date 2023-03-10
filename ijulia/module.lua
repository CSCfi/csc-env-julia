help([[
Julia kernel for Jupyter.
]])

local JUPYTER_BIN = "/appl/soft/math/julia/jupyter-env/bin"
local JULIA_LOAD_PATH = (os.getenv("JULIA_LOAD_PATH") or "") .. ":/appl/soft/math/julia/depot/environments/v1.8_ijulia"

depends_on("julia/1.8.5")
prepend_path("PATH", JUPYTER_BIN)
setenv("JULIA_LOAD_PATH", JULIA_LOAD_PATH)

if (mode() == "load") then
    LmodMessage("Julia kernel for Jupyter loaded")
end
