help("The Julia programming language")
whatis("Name: " .. myModuleName())
whatis("Version " .. myModuleVersion())
whatis("Description: The Julia programming language")
whatis("URL: http://julialang.org")

local appl_dir = "/appl/soft/math/julia"
local version = myModuleVersion()
local version_major, version_minor = version:match("(%d+)%.(%d+)")
local release_dir = pathJoin(appl_dir, "julia-" .. version)
local depot_dir = pathJoin(appl_dir, "depot")
local environment_dir = pathJoin(depot_dir, "environments/v" .. version_major .. "." .. version_minor .. "_shared")

setenv("CSC_JULIA_APPL_DIR", appl_dir)
setenv("CSC_JULIA_DEPOT_DIR", depot_dir)
setenv("CSC_JULIA_ENVIRONMENT_DIR", environment_dir)

depends_on("<compiler>", "<mpi>", "...")

prepend_path("PATH", pathJoin(release_dir, "bin"))
prepend_path("MANPATH", pathJoin(release_dir, "share/man"))
--prepend_path("LD_LIBRARY_PATH", pathJoin(release_dir, "lib"))

append_path("JULIA_DEPOT_PATH", pathJoin(os.getenv("HOME"), ".julia"))
append_path("JULIA_DEPOT_PATH", depot_dir)
append_path("JULIA_DEPOT_PATH", pathJoin(release_dir, "share/julia"))

append_path("JULIA_LOAD_PATH", "@")
append_path("JULIA_LOAD_PATH", "@v#.#")
append_path("JULIA_LOAD_PATH", "@stdlib")
append_path("JULIA_LOAD_PATH", environment_dir)

local num_threads = os.getenv("SLURM_CPUS_PER_TASK") or "1"
setenv("JULIA_CPU_THREADS", num_threads)
setenv("JULIA_NUM_THREADS", num_threads)
setenv("OPENBLAS_NUM_THREADS", num_threads)
setenv("MKL_NUM_THREADS", num_threads)
