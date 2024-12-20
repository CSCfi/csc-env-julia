using MPI
using HDF5

MPI.Init()
comm = MPI.COMM_WORLD
io = h5open("tmp", "w", comm)
close(io)
MPI.Finalize()
