depends_on("gcc/11", "openmpi/4", "cuda/11", "julia/1.8.5")

unsetenv("JULIA_LOAD_PATH")
setenv("JULIA_DEPOT_PATH", "/appl/soft/math/julia/depot")
setenv("JULIA_PROJECT", "/appl/soft/math/julia/depot/environments/v1.8_shared")

-- Diretory for the Julia kernel
setenv("JUPYTER_DATA_DIR", "/appl/soft/math/julia/jupyter")

-- Jupyter executable name
setenv("JUPYTER", "jupyter")
