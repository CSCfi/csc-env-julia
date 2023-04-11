-- Module dependecies for installing packages.
depends_on("gcc/11", "openmpi/4", "cuda/11", "julia/1.8.5")

-- We use the default load path by unsetting the environment variable.
unsetenv("JULIA_LOAD_PATH")

-- Directory for the shared packages and other depots.
setenv("JULIA_DEPOT_PATH", "/appl/soft/math/julia/depot")

-- Directory for the shared environment.
setenv("JULIA_PROJECT", "/appl/soft/math/julia/depot/environments/v1.8_shared")

-- Disable history when installing shared packages.
setenv("JULIA_HISTORY", "/dev/null")

-- Diretory for the Julia kernel
setenv("JUPYTER_DATA_DIR", "/appl/soft/math/julia/jupyter")

-- Jupyter executable name
setenv("JUPYTER", "jupyter")

-- IJulia version 1.24.0 this causes an error. Uncomment when it is fixed.
-- setenv("IJULIA_NODEFAULTKERNEL", "")
