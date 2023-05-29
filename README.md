# CSC Julia Environment
Intruction for installing the [Julia language](https://julialang.org/) and configuring a shared environment on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/) and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance clusters.
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for managing environments and [Slurm](https://slurm.schedmd.com/) for managing workloads.
The [Julia source code](https://github.com/JuliaLang/julia) is at GitHub.


## Installation paths
The `CSC_APPL_DIR` is `/appl` in Puhti and Mahti and `/appl/local/csc` in LUMI.

```txt
$CSC_APPL_DIR
├── modulefiles/
│   └── julia/                # Julia modulefiles
│       ├── 1.8.5.lua         # Modulefile for Julia v1.8.5
│       └── 1.9.0.lua         # Modulefile for Julia v1.9.0
└── soft/math/julia/
    ├── depot/                # Shared Julia depots such as installed packages, etc
    │   └── environments/     # Shared Julia environments
    │       ├── v1.8_shared/  # Shared environment for Julia v1.8.*
    │       └── v1.9_shared/  # Shared environment for Julia v1.9.*
    ├── julia-1.8.5/          # Julia v1.8.5 pre-compiled binaries
    ├── julia-1.9.0/          # Julia v1.9.0 pre-compiled binaries
    ├── jupyter/              # Julia kernels for Jupyter
    └── jupyter-env/          # Private Jupyter installation for Julia
```


## Installing Julia release
Download and unpack the pre-compiled binaries of a [Julia release](https://julialang.org/downloads/) to the Julia application directory.

Puhti and Mahti:

```bash
cd "/appl/soft/math/julia"
wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.0-linux-x86_64.tar.gz
tar xf julia-1.9.0-linux-x86_64.tar.gz
```

LUMI:

```bash
cd "/appl/local/csc/soft/math/julia"
wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.0-linux-x86_64.tar.gz
tar xf julia-1.9.0-linux-x86_64.tar.gz
```


## Structure of Julia binaries
A Julia release, such as `julia-1.9.0`, contains the following files and directories among others.

- `bin` directory contains the Julia executable which is dynamically linked to various libraries.
  We must include this location in `PATH`.
- `lib` directory contains shared libraries for the Julia executable.
  These libraries are on the `RUNPATH` and can be overwritten by libraries on the `LD_LIBRARY_PATH` environment variable.
  We can use `ldd` or [`libtree`](https://github.com/haampie/libtree) to check which libraries are loaded and their paths.
- `include` directory contains header files.
- `libexec` contains executables which Julia uses internally.
- `share/man` contains man pages.
  We should add this directory to the `MANPATH` environment variable.
- `share/julia/base` directory contains the base library.
- `share/julia/stdlib` directory contains the standard libraries.
- `share/julia/test` directory contains tests for base.
  We can run the test by executing the `runtests.jl` files which run tests for the base and standard libraries.
- `etc/julia/startup.jl` is a startup script that is executed after Julia starts.


## Using modulefiles during development
During development, we must add the modulefiles to the module path as follows.

Puhti:

```bash
module purge
module use "$PWD/modulefiles/puhti"
```

Mahti:

```bash
module purge
module use "$PWD/modulefiles/mahti"
```

LUMI:

```bash
module purge
module use "$PWD/modulefiles/lumi"
```


## Installing shared packages
We must add the modulefiles to the modulepath to make them available on the current shell session.
Then, we can load the environment for installing shared Julia packages and install packages by running scripts inside the `packages` directory.
Finally, we must instantiate the packages using the instantiate script.

Puhti:

```bash
module load julia/1.9.0 julia-pkg
julia packages/mkl.jl
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/ijulia.jl
julia packages/ijulia_installkernel.jl
julia packages/instantiate.jl
```

Mahti:

```bash
module load julia/1.9.0 julia-pkg
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/ijulia.jl
julia packages/ijulia_installkernel.jl
julia packages/instantiate.jl
```

LUMI:

```bash
module load julia/1.9.0 julia-pkg
julia packages/mpi.jl
julia packages/amdgpu.jl
julia packages/instantiate.jl
```


## Testing Julia and shared packages
Run tests for Julia and shared packages.

Puhti:

```bash
module unload julia-pkg
module load julia/1.9.0 julia-test
(cd test/julia && ./sbatch puhti)
(cd test/mpi && ./sbatch puhti)
(cd test/cuda && ./sbatch puhti)
```

Mahti:

```bash
module unload julia-pkg
module load julia/1.9.0 julia-test
(cd test/julia && ./sbatch mahti)
(cd test/mpi && ./sbatch mahti)
(cd test/cuda && ./sbatch mahti)
```

LUMI:

```bash
module unload julia-pkg
module load julia/1.9.0 julia-test
(cd test/julia && ./sbatch lumi_c)
(cd test/mpi && ./sbatch lumi_c)
(cd test/amdgpu && ./sbatch lumi_g)
```


## Adding Julia module
If the tests pass, we can make the Julia installation available to users by adding a Julia module to the modulefiles directory.
We need to copy the Julia module to the modulefiles directory.

Puhti:

```bash
cp modulefiles/puhti/julia/1.9.0.lua /appl/modulefiles/julia/1.9.0.lua
cp modulefiles/puhti/julia-jupyter.lua /appl/modulefiles/julia-jupyter/env.lua
```

Mahti:

```bash
cp modulefiles/mahti/julia/1.9.0.lua /appl/modulefiles/julia/1.9.0.lua
cp modulefiles/mahti/julia-jupyter.lua /appl/modulefiles/julia-jupyter/env.lua
```

LUMI:

```bash
cp modulefiles/lumi/julia/1.9.0.lua /appl/local/csc/modulefiles/julia/1.9.0.lua
```


## Testing Julia module
We can test the Julia module by loading it, checking the Julia version and checking the path to the Julia man pages.

```bash
module purge
module load julia/1.9.0
```

```bash
julia --version
```

```bash
man -w julia
```

