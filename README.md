# CSC Julia Environment
## Systems
- Puhti and Mahti
- Local installation on LUMI


## Installation paths
Puhti and Mahti

- Julia modulefiles directory: `/appl/modulefiles/julia`
- Julia Jupyter modulefiles directory: `/appl/modulefiles/julia-jupyter`
- Julia application directory: `/appl/soft/math/julia`

LUMI

- Julia modulefiles directory: `/appl/local/csc/modulefiles/julia`
- Julia application directory: `/appl/local/csc/soft/math/julia`

Subdirectories in the Julia application directory

- Julia installation directory: `julia-v#.#.#`
- Shared Julia depot directory: `depot`
- Directory for Julia kernels for Jupyter: `jupyter`
- Direcotry for Jupyter installation for Julia: `jupyter-env`


## Installing Julia
Download and unpack the Julia binaries to the Julia application directory.

```bash
export JULIA_APPLDIR="/appl/soft/math/julia"
export JULIA_VERSION="1.8.5"
bash julia/binary.sh
```


## Installing shared Julia packages
First, we must add the modulefiles to the modulepath.

```bash
source modulefiles/env.sh
```

Then, we can load the `julia-packages` module.

```bash
module load julia-packages/1.8.5
```

Now, we can install packages by running install scripts.

```bash
julia packages/mkl.jl
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/ijulia.jl
julia packages/ijulia_installkernel.jl
```

Finally, we must instantiate the installed packages.

```bash
julia packages/instantiate.jl
```


## Running tests
Run tests for Julia and installed packages.


## Adding modulefiles
If the tests pass, we can make the Julia installation available to users by adding a Julia module to the modulefiles directory.
We need to copy the Julia module to the modulefiles directory.

```bash
cp modulefiles/julia/1.8.5.lua /appl/modulefiles/julia/1.8.5.lua
```

Note that we need to change the version string if we install a diffent version.

