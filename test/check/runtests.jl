using Test

import InteractiveUtils
InteractiveUtils.versioninfo()

const csc_system_name = ENV["CSC_SYSTEM_NAME"]
const ispuhti = csc_system_name == "puhti"
const ismahti = csc_system_name == "mahti"
const islumi = csc_system_name == "lumi"

if ispuhti || ismahti
    const csc_appl_dir = "/appl"
else if islumi
    const csc_appl_dir = "/appl/local/csc"
else
    throw(ArgumentError("wrong system name"))
end
const csc_julia_appl_dir = joinpath(csc_appl_dir, "soft/math/julia")

@info "Depot path"
@test length(DEPOT_PATH) == 3
@test DEPOT_PATH[1] == joinpath(homedir(), ".julia")
@test DEPOT_PATH[2] == joinpath(csc_julia_appl_dir, "depot")
@test DEPOT_PATH[3] == joinpath(csc_julia_appl_dir, "julia-$(VERSION)", "share", "julia")

@info "Load path"
const site_environment_dir = joinpath(csc_julia_appl_dir, "depot", "environments", "v$(VERSION.major).$(VERSION.minor)_shared")
@test length(LOAD_PATH) == 4
@test LOAD_PATH[1] == "@"
@test LOAD_PATH[2] == "@#.#"
@test LOAD_PATH[3] == "@stdlib"
@test LOAD_PATH[4] == site_environment_dir

const default_project = joinpath(homedir(), ".julia", "environments", "v$(VERSION.major).$(VERSION.minor)", "Project.toml")

@info "Expanded load path"
const load_path = Base.load_path()
const stdlib_dir = joinpath(csc_julia_appl_dir, "julia-$(VERSION)", "share", "julia", "stdlib", "v$(VERSION.major).$(VERSION.minor)")
@test length(load_path) == 3
@test load_path[1] = default_project
@test load_path[2] = stdlib_dir
@test load_path[3] = joinpath(site_environment_dir, "Project.toml")

@info "Check that the default environment is the default user location."
@test Base.active_project() == default_project

@info "We change the default user depot to a clean temporary depot to avoid side-effects."
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

@info "Check that Julia man pages are available"
const julia_man = joinpath(csc_julia_appl_dir, "julia-$(VERSION)", "share", "julia", "man", "man1", "julia.1")
@test contains(first(readlines(`man -w julia`)), julia_man)

@info "Check that MPI is available as a shared package."
import MPI
@test contains(pathof(MPI), joinpath(csc_julia_appl_dir, "depot", "packages" , "MPI"))

if ispuhti || ismahti
    @info "Check that IJulia is available as a shared package."
    import IJulia
    @test contains(pathof(IJulia), joinpath(csc_julia_appl_dir, "depot", "packages", "IJulia"))
end

if ispuhti || ismahti
    @info "Check that CUDA is available as a shared package."
    import CUDA
    @test contains(pathof(CUDA), joinpath(csc_julia_appl_dir, "depot", "packages", "CUDA"))
end

if islumi
    @info "Check that AMDPGU is available as a shared package."
    import AMDPGU
    @test contains(pathof(AMDPGU), joinpath(csc_julia_appl_dir, "depot", "packages", "CUDA"))
end

