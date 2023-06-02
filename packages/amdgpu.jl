using Pkg
# Do not disable artifact during installation
pop!(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", nothing)
Pkg.add(name="AMDGPU", version="0.4.13")
Pkg.pin("AMDGPU")
