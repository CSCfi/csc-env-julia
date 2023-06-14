# Print information about the installation
println(VERSION)
println(DEPOT_PATH)
println(LOAD_PATH)
println(Base.load_path())
println(Base.active_project())

# Check stdlib availability
using Test

# Check that the default environment is in user location
@test Base.active_project() == joinpath(homedir(), ".julia", "environments", "v$(VERSION.major).$(VERSION.minor)", "Project.toml")

# Check that environments work
tmp = mktempdir()
pushfirst!(DEPOT_PATH, joinpath(tmp, ".julia"))
import Pkg
Pkg.activate(tmp)
Pkg.compat("julia", string(VERSION))
Pkg.add("Example")
Pkg.instantiate()
import Example
popfirst!(DEPOT_PATH)

# Check that MPI is available as a shared package
import MPI
@test contains(pathof(MPI), "/appl/soft/math/julia/depot")

# Check that IJulia is available as a shared package
import IJulia
@test contains(pathof(IJulia), "/appl/soft/math/julia/depot")
