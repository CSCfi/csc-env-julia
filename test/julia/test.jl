julia_appldir = dirname(Sys.BINDDIR)
testfile = joinpath(julia_appldir, "share", "julia", "test", "runtest.jl")
include("testfile")
