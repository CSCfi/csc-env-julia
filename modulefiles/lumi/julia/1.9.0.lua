help("The Julia programming language")
whatis("Name: " .. myModuleName())
whatis("Version: " .. myModuleVersion())
whatis("Description: The Julia programming language")
whatis("URL: http://julialang.org")

local appl_dir = "/appl/local/csc/soft/math/julia"
local version = myModuleVersion()
local release_dir = pathJoin(appl_dir, "julia-" .. version)

depends_on("PrgEnv-cray")
--depends_on("gcc/11", "PrgEnv-gnu")

prepend_path("PATH", pathJoin(release_dir, "bin"))
prepend_path("MANPATH", pathJoin(release_dir, "share/man"))
--prepend_path("LD_LIBRARY_PATH", pathJoin(release_dir, "lib"))

local user_depot_dir = pathJoin(os.getenv("HOME"), ".julia")
local site_depot_dir = pathJoin(appl_dir, "depot")
local julia_depot_dir = pathJoin(release_dir, "share/julia")

append_path("JULIA_DEPOT_PATH", user_depot_dir)
append_path("JULIA_DEPOT_PATH", site_depot_dir)
append_path("JULIA_DEPOT_PATH", julia_depot_dir)

local version_major, version_minor = version:match("(%d+)%.(%d+)")
local site_environment_dir = pathJoin(site_depot_dir, "environments/v" .. version_major .. "." .. version_minor .. "_shared")

append_path("JULIA_LOAD_PATH", "@")
append_path("JULIA_LOAD_PATH", "@v#.#")
append_path("JULIA_LOAD_PATH", "@stdlib")
append_path("JULIA_LOAD_PATH", site_environment_dir)

local num_threads = os.getenv("SLURM_CPUS_PER_TASK") or "1"

setenv("JULIA_CPU_THREADS", num_threads)
setenv("JULIA_NUM_THREADS", num_threads)
setenv("OPENBLAS_NUM_THREADS", num_threads)
setenv("MKL_NUM_THREADS", num_threads)

setenv("CSC_JULIA_APPL_DIR", appl_dir)
setenv("CSC_JULIA_DEPOT_DIR", site_depot_dir)
setenv("CSC_JULIA_ENVIRONMENT_DIR", site_environment_dir)

