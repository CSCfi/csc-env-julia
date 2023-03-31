using Pkg

# Install IJulia
Pkg.add(name="IJulia", version="1.24.0")

# Pin the version of IJulia to avoid updating it accidentally.
# We can use Pkg.free to unpin it.
Pkg.pin("IJulia")

# Remove the default kernel
jupyter_dir = ENV["JUPYTER_DATA_DIR"]
rm(joinpath(jupyter_dir, "kernels", "julia-$(VERSION.major).$(VERSION.minor)"); recursive=true, force=true)
