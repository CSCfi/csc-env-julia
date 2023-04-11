# Find Julia application directory
JULIA_APPLDIR = dirname(Sys.BINDIR)

# Path to the file to that contains tests for Julia's Base and Stdlib
testfile = joinpath(JULIA_APPLDIR, "share", "julia", "test", "runtests.jl")

# Include the file to run the tests
include(testfile)
