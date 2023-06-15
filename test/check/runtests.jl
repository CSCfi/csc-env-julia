using Test

import InteractiveUtils
InteractiveUtils.versioninfo()

const csc_system_name = ENV["CSC_SYSTEM_NAME"]
const ispuhti = csc_system_name == "puhti"
const ismahti = csc_system_name == "mahti"
const islumi = csc_system_name == "lumi"

if ispuhti || ismahti
    const csc_appl_dir = "/appl"
elseif islumi
    const csc_appl_dir = "/appl/local/csc"
else
    throw(ArgumentError("wrong system name"))
end
const csc_julia_appl_dir = joinpath(csc_appl_dir, "soft/math/julia")

@testset "DEPOT_PATH" begin
    @test haskey(ENV, "JULIA_DEPOT_PATH")
    @test length(DEPOT_PATH) == 3
    @test DEPOT_PATH[1] == joinpath(homedir(), ".julia")
    @test DEPOT_PATH[2] == joinpath(csc_julia_appl_dir, "depot")
    @test DEPOT_PATH[3] == joinpath(csc_julia_appl_dir, "julia-$(VERSION)", "share", "julia")
end

const site_environment_dir = joinpath(csc_julia_appl_dir, "depot", "environments", "v$(VERSION.major).$(VERSION.minor)_shared")

@testset "LOAD_PATH" begin
    @test haskey(ENV, "JULIA_LOAD_PATH")
    @test length(LOAD_PATH) == 4
    @test LOAD_PATH[1] == "@"
    @test LOAD_PATH[2] == "@v#.#"
    @test LOAD_PATH[3] == "@stdlib"
    @test LOAD_PATH[4] == site_environment_dir
end

const load_path = Base.load_path()
const default_project = joinpath(homedir(), ".julia", "environments", "v$(VERSION.major).$(VERSION.minor)", "Project.toml")
const stdlib_dir = joinpath(csc_julia_appl_dir, "julia-$(VERSION)", "share", "julia", "stdlib", "v$(VERSION.major).$(VERSION.minor)")

@testset "Expanded load path and active project" begin
    @test length(load_path) == 3
    @test load_path[1] == default_project
    @test load_path[2] == stdlib_dir
    @test load_path[3] == joinpath(site_environment_dir, "Project.toml")
    @test Base.active_project() == default_project
end

@testset "Environment variables" begin
    @test haskey(ENV, "JULIA_CPU_THREADS")
    @test all(isdigit.(collect(ENV["JULIA_CPU_THREADS"])))
    @test haskey(ENV, "JULIA_NUM_THREADS")
    @test all(isdigit.(collect(ENV["JULIA_NUM_THREADS"])))
end

@info "We change the default user depot to a clean temporary depot to avoid side-effects."
popfirst!(DEPOT_PATH)
tmp = mktempdir(; cleanup=true)
pushfirst!(DEPOT_PATH, joinpath(tmp, ".julia"))

@testset "Using environments" begin
    import Pkg
    Pkg.activate(tmp)
    Pkg.compat("julia", string(VERSION))
    Pkg.add("Example")
    Pkg.instantiate()
    import Example
end

@testset "Man pages" begin
    @info "Check that Julia man pages are available"
    const julia_man = joinpath(csc_julia_appl_dir, "julia-$(VERSION)", "share", "man", "man1", "julia.1")
    @test first(readlines(`man -w julia`)) == julia_man
end

@testset "Shared packages" begin
    @info "Check that MPI is available as a shared package."
    import MPI
    @test contains(pathof(MPI), joinpath(csc_julia_appl_dir, "depot", "packages" , "MPI"))

    @info "Check that IJulia is available as a shared package."
    import IJulia
    @test contains(pathof(IJulia), joinpath(csc_julia_appl_dir, "depot", "packages", "IJulia")) skip=islumi

    @info "Check that CUDA is available as a shared package."
    import CUDA
    @test contains(pathof(CUDA), joinpath(csc_julia_appl_dir, "depot", "packages", "CUDA")) skip=islumi

    @info "Check that AMDPGU is available as a shared package."
    import AMDPGU
    @test contains(pathof(AMDPGU), joinpath(csc_julia_appl_dir, "depot", "packages", "CUDA")) skip=(ispuhti || ismahti)
end
