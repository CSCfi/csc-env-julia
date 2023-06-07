# CSC Julia Environment
Instructions for installing the [Julia language](https://julialang.org/) and configuring a shared environment on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/) and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance clusters.
We install and configure MPI and GPU packages in the shared environment.
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for environment modules and [Slurm](https://slurm.schedmd.com/) for managing workloads.
The [Julia source code](https://github.com/JuliaLang/julia) is at GitHub.


## Development environment
We denote the system names and application directory as follows:

`CSC_SYSTEM_NAME`|`CSC_APPL_DIR`
-|-
`puhti`|`/appl`
`mahti`|`/appl`
`lumi`|`/appl/local/csc`

During development, we must add the modulefiles to the modulepath to make them available on the current shell session.

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
A Julia release, such as `julia-1.9.0`, contains the following files and directories, among others.

-  The `bin` directory contains the Julia executable, which is dynamically linked to various libraries.
- The `lib` directory contains shared libraries for the Julia executable.
  These libraries are on the `RUNPATH` and can be overwritten by libraries on the `LD_LIBRARY_PATH` environment variable.
  We can use `ldd` or [`libtree`](https://github.com/haampie/libtree) to check which libraries are loaded and their paths.
- The `include` directory contains header files.
- The `libexec` contains executables that Julia uses internally.
- The `share/man` contains man pages.
- The `share/julia/base` directory contains the base library.
- The `share/julia/stdlib` directory contains the standard libraries.
- The `share/julia/test` directory contains tests for the base.
  We can run the test by executing the `runtests.jl` files which run tests for the base and standard libraries.
- The `etc/julia/startup.jl` is a startup script that is executed when we invoke the Julia command.


## Julia environment module
The Julia environment module defines an environment for loading the dependencies for the programming environment and MPI, running the Julia command, and loading shared Julia packages.
Furthermore, the module defines default Julia's CPU and thread counts, based on Slurm reservation if one exists (e.g. in slurm job) and otherwise sets them to one (e.g. on login nodes).
The modulefile is placed in the `julia` directory and named as`<version>.lua`, for example, `julia/1.9.0.lua`.
A Julia environment module template is available here: [`julia/x.y.z.lua`](./modulefiles/template/julia/x.y.z.lua).

The Julia environment module makes `julia` command available by prepending the `bin` directory to `PATH` and `man julia` command available by prepending the `share/man` directory to `MANPATH`.
The environment module also defines the depot and load paths that control Julia's [code loading](https://docs.julialang.org/en/v1/manual/code-loading/) mechanism.
We can populate Julia's [`DEPOT_PATH`](https://docs.julialang.org/en/v1/base/constants/#Base.DEPOT_PATH) constant by setting `JULIA_DEPOT_PATH` environment variable and Julia' [`LOAD_PATH`](https://docs.julialang.org/en/v1/base/constants/#Base.LOAD_PATH) constant by setting `JULIA_LOAD_PATH` environment variable.
The module appends a user-specific depot directory (`$HOME/.julia`), a site-specific shared depot directory, and Julia-specific shared depot directory (`share/julia`) to the depot path.
The module appends the current environment (`@`), default environment (`@v#.#`), standard library (`@stdlib`) and site-specific shared environment directory to the load path.


## Installing shared packages
We can load the environment for installing shared Julia packages and install packages by running scripts inside the `packages` directory.
Finally, we must instantiate the packages using the instantiate script.

Puhti:

```bash
module load julia/1.9.0 julia-cuda/1.9.0 julia-pkg
umask u=rwx,go=rx
julia packages/mkl.jl
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/instantiate.jl
```

Mahti:

```bash
module load julia/1.9.0 julia-cuda/1.9.0 julia-pkg
umask u=rwx,go=rx
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/instantiate.jl
```

LUMI:

```bash
module load julia/1.9.0 julia-amdgpu/1.9.0 julia-pkg
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
module load julia-test
export JULIA_VERSION=1.9.0
(cd test/julia && ./sbatch puhti)
(cd test/mpi && ./sbatch puhti)
(cd test/cuda && ./sbatch puhti)
```

Mahti:

```bash
module unload julia-pkg
module load julia-test
export JULIA_VERSION=1.9.0
(cd test/julia && ./sbatch mahti)
(cd test/mpi && ./sbatch mahti)
(cd test/cuda && ./sbatch mahti)
```

LUMI:

```bash
module unload julia-pkg
module load julia-test
export JULIA_VERSION=1.9.0
(cd test/julia && ./sbatch lumi)
(cd test/mpi && ./sbatch lumi)
(cd test/amdgpu && ./sbatch lumi)
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


## Julia-Jupyter
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

Install Jupyter on Python virtual environment.

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
