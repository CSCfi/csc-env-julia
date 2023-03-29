using Pkg

dir = ENV["JUPYTER_DATA_DIR"]
mkpath(dir)

Pkg.add(name="IJulia", version="1.24.0")
kernel = """
{
  "display_name": "julia 1.8.5",
  "argv": [
    "julia",
    "-i",
    "--color=yes",
    "--project=@.",
    "/appl/soft/math/julia/depot/packages/IJulia/6TIq1/src/kernel.jl",
    "{connection_file}"
  ],
  "language": "julia",
  "env": {},
  "interrupt_mode": "signal"
}
"""
kernel_path = joinpath(dir, "kernels", "julia-1.8", "kernel.json")
write(kernel_path, kernel)
