# Install LocalPreferences.toml for HDF5 parallel.
#
# $ module use /appl/local/csc/modulefiles
# $ module load julia
# $ module load cray-hdf5-parallel
# $ julia --threads 8 ./setup.jl

using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Preferences
using HDF5

hdf5_dir = ENV["HDF5_DIR"]
set_preferences!(
    HDF5,
    "libhdf5" => joinpath(hdf5_dir, "lib", "libhdf5.so"),
    "libhdf5_hl" => joinpath(hdf5_dir, "lib", "libhdf5_hl.so"),
    force = true
)
