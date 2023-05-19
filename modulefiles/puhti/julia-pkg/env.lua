-- Installing packages requires loading the julia module.
prereq_any("julia/1.8.5", "julia/1.9.0")

-- We use the default load path by unsetting the environment variable.
unsetenv("JULIA_LOAD_PATH")

-- Directory for the shared packages and other depots.
setenv("JULIA_DEPOT_PATH", os.getenv("CSC_JULIA_DEPOT_DIR"))

-- Directory for the shared environment.
setenv("JULIA_PROJECT", os.getenv("CSC_JULIA_ENVIRONMENT_DIR"))

-- Disable history when installing shared packages.
setenv("JULIA_HISTORY", "/dev/null")
