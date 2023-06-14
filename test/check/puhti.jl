@info "Print information about the installation"
println(VERSION)
println(DEPOT_PATH)
println(LOAD_PATH)
println(Base.load_path())
println(Base.active_project())

@info "Check stdlib availability"
using Test

@info "Check that the default environment is the default user location."
@test Base.active_project() == joinpath(homedir(), ".julia", "environments", "v$(VERSION.major).$(VERSION.minor)", "Project.toml")

@info "Lets change the default user depot to a clean, temporary one."
popfirst!(DEPOT_PATH)
tmp = mktempdir(; cleanup=true)
pushfirst!(DEPOT_PATH, joinpath(tmp, ".julia"))

@info "Check that environments work"
import Pkg
Pkg.activate(tmp)
Pkg.compat("julia", string(VERSION))
Pkg.add("Example")
Pkg.instantiate()
import Example

@info "Check that MPI is available as a shared package."
import MPI
@test contains(pathof(MPI), "/appl/soft/math/julia/depot")

@info "Check that CUDA is available as a shared package."
import CUDA
@test contains(pathof(CUDA), "/appl/soft/math/julia/depot")

@info "Check that IJulia is available as a shared package."
import IJulia
@test contains(pathof(IJulia), "/appl/soft/math/julia/depot")
