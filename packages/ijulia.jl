using Pkg

copy_config(src, dest) = cp(src, joinpath(dest, basename(src)), force=true)

jupyter_dir = ENV["JUPYTER_DATA_DIR"]
kernel_dir = joinpath(jupyter_dir, "kernels", "julia-$(Base.VERSION_STRING)")
mkpath(kernel_dir)

# Install IJulia
Pkg.add(name="IJulia", version="1.24.0")

# Pin the version of IJulia to avoid updating it accidentally.
# We can use Pkg.free to unpin it.
Pkg.pin("IJulia")

# Remove the default kernel
rm(joinpath(dir, "kernels", "julia-$(VERSION.major).$(VERSION.minor)"); recursive=true)

# Directory to IJulia installation
ijulia_dir = "/appl/soft/math/julia/depot/packages/IJulia/6TIq1"

julia_script = """
#!/usr/bin/env bash
module load julia/$(Base.VERSION_STRING)
exec julia "\$@"
"""

kernelspec = """
{
  "display_name": "julia $(Base.VERSION_STRING)",
  "argv": [
    "$(joinpath(kernel_dir, "julia.sh"))",
    "-i",
    "--color=yes",
    "--project=@.",
    "$(joinpath(ijulia_dir, "src", "kernel.jl"))",
    "{connection_file}"
  ],
  "language": "julia",
  "env": {},
  "interrupt_mode": "signal"
}
"""

write(joinpath(kernel_dir, "kernel.json"), kernelspec)

write(joinpath(kernel_dir, "julia.sh"), julia_script)
chmod(joinpath(kernel_dir, "julia.sh"), 0o775)

copy_config(joinpath(ijulia_dir,"deps","logo-32x32.png"), kernel_dir)
copy_config(joinpath(ijulia_dir,"deps","logo-64x64.png"), kernel_dir)
copy_config(joinpath(ijulia_dir,"deps","logo-svg.svg"), kernel_dir)
