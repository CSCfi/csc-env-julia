using MPI
using HDF5

MPI.Init()
comm = MPI.COMM_WORLD
io = h5open("tmp.hdf5", "w", comm)
close(io)
MPI.Finalize()
