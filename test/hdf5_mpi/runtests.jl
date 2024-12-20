using MPI
using HDF5

MPI.Init()
comm = MPI.COMM_WORLD
h5open("tmp", "w", comm)
MPI.Finalize()
