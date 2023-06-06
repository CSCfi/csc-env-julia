# CSC Julia Environment
Intruction for installing the [Julia language](https://julialang.org/) and configuring a shared environment on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/) and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance clusters.
We install and configure packages for MPI and GPU support to the shared environment.
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for managing environments and [Slurm](https://slurm.schedmd.com/) for managing workloads.
The [Julia source code](https://github.com/JuliaLang/julia) is at GitHub.


## Development environment
We denote the system names and application directory as follows:

Puhti:
- `CSC_SYSTEM_NAME=puhti`
- `CSC_APPL_DIR=/appl`

Mahti:
- `CSC_SYSTEM_NAME=mahti`
- `CSC_APPL_DIR=/appl`

LUMI:
- `CSC_SYSTEM_NAME=lumi`
- `CSC_APPL_DIR=/appl/local/csc`

During development, we must add the modulefiles to the module path as follows.

```bash
module purge
module use "$PWD/modulefiles/dev"
module load ...  # puhti | mahti | lumi
```


## Julia installation paths
The Julia installation is structured as follows:

```txt
$CSC_APPL_DIR/
├── modulefiles/julia         # Modulefiles for different version of Julia
│   ├── 1.8.5.lua             # Modulefile for Julia v1.8.5
│   └── 1.9.0.lua             # Modulefile for Julia v1.9.0
└── soft/math/julia/          # Julia application directory
    ├── depot/                # Shared Julia depots such as installed packages, etc
    │   └── environments/     # Shared Julia environments
    │       ├── v1.8_shared/  # Shared environment for Julia v1.8.*
    │       └── v1.9_shared/  # Shared environment for Julia v1.9.*
    ├── julia-1.8.5/          # Julia v1.8.5 binaries
    └── julia-1.9.0/          # Julia v1.9.0 binaries
```


## Installing Julia binaries
We can install Julia by downloading and unpacking the [pre-compiled Julia binaries](https://julialang.org/downloads/) to the Julia application directory.

```bash
cd "$CSC_APPL_DIR/soft/math/julia"
wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.0-linux-x86_64.tar.gz
umask u=rwx,go=rx
tar xf julia-1.9.0-linux-x86_64.tar.gz
rm julia-1.9.0-linux-x86_64.tar.gz
```


## Structure of Julia binaries
A Julia release, such as `julia-1.9.0`, contains the following files and directories among others.

- `bin` directory contains the Julia executable which is dynamically linked to various libraries.
- `lib` directory contains shared libraries for the Julia executable.
  These libraries are on the `RUNPATH` and can be overwritten by libraries on the `LD_LIBRARY_PATH` environment variable.
  We can use `ldd` or [`libtree`](https://github.com/haampie/libtree) to check which libraries are loaded and their paths.
- `include` directory contains header files.
- `libexec` contains executables which Julia uses internally.
- `share/man` contains man pages.
- `share/julia/base` directory contains the base library.
- `share/julia/stdlib` directory contains the standard libraries.
- `share/julia/test` directory contains tests for base.
  We can run the test by executing the `runtests.jl` files which run tests for the base and standard libraries.
- `etc/julia/startup.jl` is a startup script that is executed after Julia starts.


## Julia modulefile
The Julia module sets the environment that allows users to run Julia, access the shared Julia environment and sets default values for threading.
The modulefile is placed to `julia` directory and using its version and `.lua` extension.
As an example of a Julia modulefile, we can look the the following template: [`julia/x.y.z.lua`](./modulefiles/template/julia/x.y.z.lua).

A Julia module loads dependencies for the programming environment and MPI.

It also sets paths to the Julia binary.
The module prepends the Julia `bin` directory to `PATH` making `julia` command available.
Also, the module prepends the Julia `share/man` to `MANPATH` making `man julia` command available.

The module also sets paths for Julia's [code loading](https://docs.julialang.org/en/v1/manual/code-loading/) mechanism.

The module appends user-specific depot diretory (`$HOME/.julia`), a site-specific shared depot directory and Julia-specific shared depot directory (`share/julia`) to the `JULIA_DEPOT_PATH` which populates the [`DEPOT_PATH`](https://docs.julialang.org/en/v1/base/constants/#Base.DEPOT_PATH) constant.

The module appends the default locations (`@`, `@#.#`, `@stdlib`) and site-specific shared environment directory to the `JULIA_LOAD_PATH` which populates the [`LOAD_PATH`](https://docs.julialang.org/en/v1/base/constants/#Base.LOAD_PATH) constant.

The module sets the thread count based on amount of reserved cpus via Slurm, `SLURM_CPUS_PER_TASK`.
The count defaults to 1 if reservation does not exist for example, on login nodes or if `--cpus-per-task`.
The module sets `JULIA_CPU_THREADS`, `JULIA_NUM_THREADS`, `OPENBLAS_NUM_THREADS`, and `MKL_NUM_THREADS`.


## Installing shared packages
We must add the modulefiles to the modulepath to make them available on the current shell session.
Then, we can load the environment for installing shared Julia packages and install packages by running scripts inside the `packages` directory.
Finally, we must instantiate the packages using the instantiate script.

Puhti:

```bash
module load julia/1.9.0 julia-pkg
umask u=rwx,go=rx
julia packages/mkl.jl
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/instantiate.jl
```

Mahti:

```bash
module load julia/1.9.0 julia-pkg
umask u=rwx,go=rx
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/instantiate.jl
```

LUMI:

```bash
module load julia/1.9.0 julia-pkg
umask u=rwx,go=rx
julia packages/mpi.jl
julia packages/amdgpu.jl
julia packages/instantiate.jl
echo 1 | bash /appl/local/csc/bin/sync_appl_csc.sh /appl/local/csc/soft/math/julia
```

On LUMI, we must synchronize the installation across the independent Lustre filesystems to make them available from each Lustre filesystem.


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

```bash
cp modulefiles/$CSC_SYSTEM_NAME/julia/1.9.0.lua $CSC_APPL_DIR/modulefiles/julia/1.9.0.lua
chmod -R o=rX $CSC_APPL_DIR/modulefiles/julia
```

LUMI:

```bash
echo 1 | bash /appl/local/csc/bin/sync_appl_csc.sh /appl/local/csc/modulefiles/julia
```


## Testing Julia module
On LUMI we must first add the modulefiles to the modulepath as follows.

```bash
module use /appl/local/csc/modulefiles
```

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


## Jupyter
Julia Jupyter directory structure

```txt
$CSC_APPL_DIR/
├── modulefiles/julia-jupyter/
│   └── env.lua                 # Sets Jupyter executable and Julia kernels to path
└── soft/math/julia-jupyter/
    ├── data/kernels/           # Julia kernels for Jupyter
    │   ├── julia-1.8.5/        # Julia v1.8.5 kernel
    │   └── julia-1.9.0/        # Julia v1.9.0 kernel
    └── env/                    # Jupyter installed on Python virtualenv
```

Install Jupyter

```bash
umask u=rwx,go=rx
./jupyter/install.sh "$CSC_APPL_DIR/soft/math/julia-jupyter/env"
```

Installing IJulia and Julia kernel.

```bash
module load julia/1.9.0 julia-pkg
umask u=rwx,go=rx
julia packages/ijulia.jl
julia packages/instantiate.jl
julia packages/ijulia_installkernel.jl
```

Adding the modulefile

```bash
cp modulefiles/$CSC_SYSTEM_NAME/julia-jupyter.lua $CSC_APPL_DIR/modulefiles/julia-jupyter/env.lua
chmod -R o=rX $CSC_APPL_DIR/modulefiles/julia-jupyter
```

Test

```bash
module load julia-jupyter
which jupyter
jupyter --paths
jupyter kernelspec list
```
