using Test

import InteractiveUtils
InteractiveUtils.versioninfo()
println()

const csc_system_name = ENV["CSC_SYSTEM_NAME"]
const ispuhti = csc_system_name == "puhti"
const ismahti = csc_system_name == "mahti"
const islumi = csc_system_name == "lumi"

if ispuhti || ismahti
    const csc_appl_dir = "/appl"
elseif islumi
    const csc_appl_dir = "/appl/local/csc"
else
    throw(ArgumentError("System \"$csc_syste_name\" not recognized"))
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

const default_project = joinpath(homedir(), ".julia", "environments", "v$(VERSION.major).$(VERSION.minor)", "Project.toml")
const stdlib_dir = joinpath(csc_julia_appl_dir, "julia-$(VERSION)", "share", "julia", "stdlib", "v$(VERSION.major).$(VERSION.minor)")

@testset "Expanded load path and active project" begin
    load_path = Base.load_path()
    @test length(load_path) == 3
    @test load_path[1] == default_project
    @test load_path[2] == realpath(stdlib_dir)
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
const tmp = mktempdir(; cleanup=true)
const tmp_depot = joinpath(tmp, ".julia")
pushfirst!(DEPOT_PATH, tmp_depot)

@testset "Using environments" begin
    @test begin
        import Pkg
        Pkg.activate(tmp)
        Pkg.compat("julia", string(VERSION))
        Pkg.add("Example")
        Pkg.instantiate()
        import Example
        true
    end
end

const julia_man = joinpath(csc_julia_appl_dir, "julia-$(VERSION)", "share", "man", "man1", "julia.1")

@testset "Man pages" begin
    @info "Check that Julia man pages are available"
    @test first(readlines(`man -w julia`)) == julia_man
end

@testset "Shared packages" begin
    @test begin
        @info "Check that MPI is available as a shared package."
        import MPI
        contains(pathof(MPI), joinpath(csc_julia_appl_dir, "depot", "packages" , "MPI"))
    end

    @test begin
        @info "Check that IJulia is available as a shared package."
        import IJulia
        contains(pathof(IJulia), joinpath(csc_julia_appl_dir, "depot", "packages", "IJulia"))
    end skip=islumi

    @test begin
        @info "Check that CUDA is available as a shared package."
        import CUDA
        contains(pathof(CUDA), joinpath(csc_julia_appl_dir, "depot", "packages", "CUDA"))
    end skip=islumi

    @test begin
        @info "Check that AMDGPU is available as a shared package."
        import AMDGPU
        contains(pathof(AMDGPU), joinpath(csc_julia_appl_dir, "depot", "packages", "AMDGPU"))
    end skip=(ispuhti || ismahti)
end

const read = 0x04
const write = 0x02
const execute = 0x01

isexecutable(perm::UInt8) = (~execute | perm) == 0xff

"""rwxrwsr-x"""
function perm1(s::Base.Filesystem.Statstruct)
    uperm(s1) == read & write & execute &&
    gperm(s1) == read & write & execute &&
    operm(s1) == read & execute
end

"""rw-rw-r--"""
function perm2(s::Base.Filesystem.Statstruct)
    uperm(s1) == read & write &&
    gperm(s1) == read & write &&
    uperm(s1) == read
end

function check_permissions(dir)
    for (root, _, files) in walkdir(dir)
        @test perm1(stat(root))
        for file in files
            if isfile(file)
                s2 = stat(file)
                if isexecutable(uperm(s2))
                    @test perm1(s2)
                else
                    @test perm2(s2)
                end
            elseif islink(file)
                continue
            else
                throw ErrorException("File is not ordinary file or link.")
            end
        end
    end
end

@testset "File permissions" begin
    # directory: rwxrwsr-x
    # file (normal): rw-rw-r--
    # file (executable): rwxrwxr-x
    check_permissions(csc_julia_appl_dir)
end
