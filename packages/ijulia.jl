using Pkg

# We set JUPYTER_DATA_DIR to temporary directory avoid install the default kernel.
ENV["JUPYTER_DATA_DIR"] = mktempdir()

# Jupyter executable name
ENV["JUPYTER"] = "jupyter"

# Install IJulia
Pkg.add(name="IJulia", version="1.24.0")

# Pin the version of IJulia to avoid updating it accidentally.
# We can use Pkg.free to unpin it.
Pkg.pin("IJulia")
