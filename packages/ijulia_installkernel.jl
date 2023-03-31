import IJulia

copy_config(src, dest) = cp(src, joinpath(dest, basename(src)), force=true)

ijulia_dir = dirname(dirname(pathof(IJulia)))
jupyter_dir = ENV["JUPYTER_DATA_DIR"]
kernel_dir = joinpath(jupyter_dir, "kernels", "julia-$(Base.VERSION_STRING)")

mkpath(kernel_dir)

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

copy_config(joinpath(ijulia_dir, "deps", "logo-32x32.png"), kernel_dir)
copy_config(joinpath(ijulia_dir, "deps", "logo-64x64.png"), kernel_dir)
copy_config(joinpath(ijulia_dir, "deps", "logo-svg.svg"), kernel_dir)
