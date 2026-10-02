#!/usr/bin/env julia

# Jupyter data dir.
const jupyter_data_dir = joinpath(homedir(), ".local", "share", "jupyter")

# Location to install the Julia kernel.
const kernel_dir = joinpath(jupyter_data_dir, "kernels", "julia-$(Base.VERSION_STRING)")

# Modules that we need to load
const modules = "julia/$(Base.VERSION_STRING)"

# Script for finding julia jupyter kernel dynamically
const run_kernel_path = joinpath(kernel_dir, "run_kernel.jl")
const run_kernel_script = """
try
    import IJulia
catch
    import Pkg
    Pkg.add("IJulia")
    import IJulia
end

if pkgversion(IJulia) >= v"1.28.0"
    IJulia.run_kernel()
else
    include(joinpath(dirname(pathof(IJulia)), "kernel.jl"))
end
"""

# Wrapper script for loading module before running a kernel.
const wrapper_path = joinpath(kernel_dir, "julia.sh")
const wrapper_script = """
#!/bin/bash
module load $modules
exec julia --interactive --color=yes "$run_kernel_path" "\$@"
"""

# Kernel specification that uses the wrapper script.
const kernel_path = joinpath(kernel_dir, "kernel.json")
const kernelspec = """
{
  "display_name": "$modules",
  "argv": [
    "$wrapper_path",
    "{connection_file}"
  ],
  "language": "julia",
  "env": {},
  "interrupt_mode": "signal"
}
"""

# Create the kernel
function copy_config(src, dir, mode)
    dest = joinpath(dir, basename(src))
    cp(src, dest, force=true)
    chmod(dest, mode)
end

const mode1 = 0o664  # rw-rw-r--
const mode2 = 0o775  # rwxrwxr-x

mkpath(kernel_dir)
write(kernel_path, kernelspec)
chmod(kernel_path, mode1)

write(run_kernel_path, run_kernel_script)
chmod(run_kernel_path, mode1)

write(wrapper_path, wrapper_script)
chmod(wrapper_path, mode2)

# We need to load IJulia to install the kernel
try
    import IJulia
catch
    import Pkg
    Pkg.add("IJulia")
    import IJulia
end

# Path to the IJulia.jl installation directory.
const ijulia_dir = dirname(dirname(pathof(IJulia)))
copy_config(joinpath(ijulia_dir, "deps", "logo-32x32.png"), kernel_dir, mode1)
copy_config(joinpath(ijulia_dir, "deps", "logo-64x64.png"), kernel_dir, mode1)
copy_config(joinpath(ijulia_dir, "deps", "logo-svg.svg"), kernel_dir, mode1)
