import IJulia

# Path to the IJulia.jl installation directory.
const ijulia_dir = dirname(dirname(pathof(IJulia)))
const julia_kernel = joinpath(ijulia_dir, "src", "kernel.jl")

# Jupyter data dir
const jupyter_dir = ENV["JUPYTER_DATA_DIR"]

# Location to install the Julia kernel.
const kernel_dir = joinpath(jupyter_dir, "kernels", "julia-$(Base.VERSION_STRING)")

# Modules that we need to load
const modules = "julia/$(Base.VERSION_STRING)"

# Wrapper script for loading module before running a kernel.
const wrapper_path = joinpath(kernel_dir, "julia.sh")
const wrapper_script = """
#!/usr/bin/env bash
module load $modules
exec julia "\$@"
"""

# Kernel specification that uses the wrapper script.
const kernel_path = joinpath(kernel_dir, "kernel.json")
const kernelspec = """
{
  "display_name": "$modules",
  "argv": [
    "$wrapper_path",
    "-i",
    "--color=yes",
    "--project=@.",
    "$julia_kernel",
    "{connection_file}"
  ],
  "language": "julia",
  "env": {},
  "interrupt_mode": "signal"
}
"""

# Create the kernel
mkpath(kernel_dir)
write(kernel_path, kernelspec)
write(wrapper_path, wrapper_script)
chmod(wrapper_path, 0o775)  # rwxrwxr-x
copy_config(src, dest) = cp(src, joinpath(dest, basename(src)), force=true)
copy_config(joinpath(ijulia_dir, "deps", "logo-32x32.png"), kernel_dir)
copy_config(joinpath(ijulia_dir, "deps", "logo-64x64.png"), kernel_dir)
copy_config(joinpath(ijulia_dir, "deps", "logo-svg.svg"), kernel_dir)
