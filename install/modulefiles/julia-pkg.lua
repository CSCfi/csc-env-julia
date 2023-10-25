-- Installing packages requires loading the julia module.
prereq("julia")

-- Use the default load path for installing shared packages.
pushenv("JULIA_LOAD_PATH", "@:@v#.#:@stdlib")

-- Directory for the shared packages and other depots.
pushenv("JULIA_DEPOT_PATH", os.getenv("CSC_JULIA_DEPOT_DIR") or "")

-- Directory for the shared environment.
pushenv("JULIA_PROJECT", os.getenv("CSC_JULIA_ENVIRONMENT_DIR") or "")

-- Disable automatic precompilation when installing packages
pushenv("JULIA_PKG_PRECOMPILE_AUTO", "0")
