help([[
Private Jupyter Notebook and Lab for Julia on Open OnDemand.
]])

local JULIA_APPLDIR = "/appl/soft/math/julia"
prepend_path("PATH", pathJoin(JULIA_APPLDIR, "jupyter-env/bin"))
