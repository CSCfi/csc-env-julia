# Install LocalPreferences.toml for parallel (MPI) HDF5.
using Pkg
Pkg.add("Preferences")
using Preferences
hdf5_dir = ENV["HDF5_DIR"]
set_preferences!(
    (Base.UUID("f67ccb44-e63f-5c2f-98bd-6dc0ccc4ba2f"), "HDF5"),
    "libhdf5" => joinpath(hdf5_dir, "lib", "libhdf5.so"),
    "libhdf5_hl" => joinpath(hdf5_dir, "lib", "libhdf5_hl.so"),
    force = true
)
