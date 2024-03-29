using Test

import InteractiveUtils
InteractiveUtils.versioninfo()
println()

const csc_system_name = ARGS[1]
const ispuhti = csc_system_name == "puhti"
const ismahti = csc_system_name == "mahti"
const islumi = csc_system_name == "lumi"

if ispuhti || ismahti
    const csc_appl_dir = joinpath("/", "appl")
elseif islumi
    const csc_appl_dir = joinpath("/", "appl", "local", "csc")
else
    throw(ArgumentError("System \"$csc_system_name\" not recognized"))
end
const csc_julia_appl_dir = joinpath(csc_appl_dir, "soft", "math", "julia")

@testset "DEPOT_PATH" begin
    @test haskey(ENV, "JULIA_DEPOT_PATH")
    @test length(DEPOT_PATH) == 2
    @test DEPOT_PATH[1] == joinpath(homedir(), ".julia")
    @test DEPOT_PATH[2] == joinpath(csc_julia_appl_dir, string(VERSION), "share", "julia")
end

@testset "LOAD_PATH" begin
    @test haskey(ENV, "JULIA_LOAD_PATH")
    @test length(LOAD_PATH) == 3
    @test LOAD_PATH[1] == "@"
    @test LOAD_PATH[2] == "@v#.#"
    @test LOAD_PATH[3] == "@stdlib"
end

const default_project = joinpath(homedir(), ".julia", "environments", "v$(VERSION.major).$(VERSION.minor)", "Project.toml")
const stdlib_dir = joinpath(csc_julia_appl_dir, string(VERSION), "share", "julia", "stdlib", "v$(VERSION.major).$(VERSION.minor)")

@testset "Expanded load path and active project" begin
    load_path = Base.load_path()
    @test length(load_path) == 2
    @test load_path[1] == default_project
    @test load_path[2] == realpath(stdlib_dir)
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

const julia_man = joinpath(csc_julia_appl_dir, string(VERSION), "share", "man", "man1", "julia.1")

@testset "Man pages" begin
    @info "Check that Julia man pages are available"
    @test first(readlines(`man -w julia`)) == julia_man
end

const read = 0x04
const write = 0x02
const execute = 0x01

isexecutable(perm::UInt8) = (~execute | perm) == 0xff

"""rwxrwsr-x"""
function perm1(s::Base.Filesystem.StatStruct)
    uperm(s) == (read | write | execute) &&
    gperm(s) == (read | execute) &&
    operm(s) == (read | execute)
end

"""rw-rw-r--"""
function perm2(s::Base.Filesystem.StatStruct)
    uperm(s) == (read | write) &&
    gperm(s) == read &&
    operm(s) == read
end

function check_permissions(dir)
    for (root, _, files) in walkdir(dir)
        # Test directory permissions
        @test perm1(lstat(root))

        # Test file permissions
        for filename in files
            file = joinpath(root, filename)
            s = lstat(file)
            if isfile(s)
                # Test ordinary file permissions
                if isexecutable(uperm(s))
                    # If the user has execute permission, the group and others should too.
                    @test perm1(s)
                else
                    @test perm2(s)
                end
            elseif islink(s)
                # Skip links
                continue
            else
                # The directory should only contains ordinary files and links.
                throw(ErrorException("File \"$file\" is not ordinary file or link."))
            end
        end
    end
end

@testset "File permissions" begin
    if islumi
        check_permissions(csc_julia_appl_dir)
    end
end
