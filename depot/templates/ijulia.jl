using Pkg

# We discard the default Julia kernel by setting Jupyter data directory to a temporary directory.
ENV["JUPYTER_DATA_DIR"] = mktempdir()

# We avoid installing Conda by setting the Jupyter executable name.
ENV["JUPYTER"] = "jupyter"

# Install package
Pkg.add(name="IJulia", version="1.24.2")
Pkg.pin("IJulia")
