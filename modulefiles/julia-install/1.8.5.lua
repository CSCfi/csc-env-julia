-- Build dependencies
-- The full list of dependecies can be found from devdocs:
-- https://github.com/JuliaLang/julia/blob/master/doc/src/devdocs/build/build.md
depends_on("gcc/11", "make", "cmake")

local JULIA_APPLDIR = "/appl/soft/math/julia"
local JULIA_VERSION = "1.8.5"

-- Julia application directory
setenv("JULIA_APPLDIR", JULIA_APPLDIR)

-- Julia version to install
setenv("JULIA_VERSION", JULIA_VERSION)

-- Compilation flags
setenv("CFLAGS", "-O2 -march=native")
