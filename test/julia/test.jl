# Path to the file to that contains tests for Julia's Base and Stdlib
testfile = joinpath(dirname(Sys.BINDIR), "share", "julia", "test", "runtests.jl")

# Include the file to run the tests
include(testfile)
