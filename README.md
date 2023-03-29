# Julia Environment
## Installing Julia
We can download the Julia source code using the download script.

```sh
./julia/download.sh 1.8.5
```

Then, we need to move the downloaded tar file to the julia application directory.

```sh
mv julia-1.8.5.tar.gz /appl/soft/math/julia
```

Finally, we can need to modulefiles to modulepath by sourcing the environment script and then we can compile Julia using by running the compile script.

```bash
source env.sh
./julia/compile.sh
```


## Shared packages
- `Base.Threads`
- `Distributed`
- `MKL.jl`
- `MPI.jl`
- `CUDA.jl`
- `AMDGPU.jl`

User interface

- `IJulia.jl`
- VSCode


## Paths
- `/appl/modulefiles/julia` contains modulefiles for julia
- `/appl/soft/math/julia` is the application directory
- `/appl/soft/math/julia/julia-v#.#.#` contains the julia installation
- `/appl/soft/math/julia/depot` contains shared packages, environments and other depots
- `/appl/soft/math/julia/jupyter` contains julia kernels for jupyter
- `/appl/soft/math/julia/jupyter-env` contains jupyter installation


## Resources
- https://docs.julialang.org/en/v1/
- https://pkgdocs.julialang.org/v1/
- https://github.com/hlrs-tasc/julia-on-hpc-systems
- https://enccs.github.io/Julia-for-HPC
- https://github.com/JuliaParallel/MPI.jl
- https://github.com/JuliaGPU/CUDA.jl

