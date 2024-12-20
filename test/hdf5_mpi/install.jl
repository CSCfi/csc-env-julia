# Install LocalPreferences.toml for HDF5 parallel.
#
# $ module use /appl/local/csc/modulefiles
# $ module load julia julia-mpi cray-hdf5-parallel
# $ julia --threads 8 ./install.jl

using Pkg
Pkg.add("Preferences")
Pkg.add("HDF5")
Pkg.precompile()

using Preferences
using HDF5

hdf5_dir = ENV["HDF5_DIR"]
set_preferences!(
    HDF5,
    "libhdf5" => joinpath(hdf5_dir, "lib", "libhdf5.so"),
    "libhdf5_hl" => joinpath(hdf5_dir, "lib", "libhdf5_hl.so"),
    force = true
)
