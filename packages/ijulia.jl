using Pkg

# We set JUPYTER_DATA_DIR to temporary directory avoid install the default kernel.
ENV["JUPYTER_DATA_DIR"] = mktempdir()

# Set Jupyter executable name to avoid installing Conda.
ENV["JUPYTER"] = "jupyter"

# Install package
Pkg.add(name="IJulia", version="1.24.0")
Pkg.pin("IJulia")
