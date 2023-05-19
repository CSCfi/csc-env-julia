# CSC Julia Environment
## Systems
- Puhti: `puhti`
- Mahti: `mahti`
- LUMI (CSC local installation): `lumi`

All systems use Lmod and Slurm.


## Installation paths
Directory for Julia modulefiles:

- Puhti:`/appl/modulefiles/julia`
- Mahti:`/appl/modulefiles/julia`
- LUMI: `/appl/local/csc/modulefiles/julia`

Directory for Julia Jupyter modulefiles:

- Puhti: `/appl/modulefiles/julia-jupyter`
- Mahti: `/appl/modulefiles/julia-jupyter`

Directory for the Julia application:

- Puhti: `/appl/soft/math/julia`
- Mahti: `/appl/soft/math/julia`
- LUMI: `/appl/local/csc/soft/math/julia`

Subdirectories in the Julia application directory:

- Directory for Julia release: `julia-v#.#.#`
- Directory for shared Julia depots: `depot`
- Directory for shared Julia environment: `depot/environments/v#.#_shared`
- Directory for Julia kernels for Jupyter: `jupyter`
- Directory for Jupyter installation for Julia: `jupyter-env`


## Installing Julia binaries
Download and unpack the [Julia binaries](https://julialang.org/downloads/) to the Julia application directory.

Puhti and Mahti:

```bash
module purge
cd "/appl/soft/math/julia"
wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.0-linux-x86_64.tar.gz
tar xf julia-1.9.0-linux-x86_64.tar.gz
```

LUMI:

```bash
module purge
cd "/appl/local/csc/soft/math/julia"
wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.0-linux-x86_64.tar.gz
tar xf julia-1.9.0-linux-x86_64.tar.gz
```


## Installing shared packages
First, we must add the modulefiles to the modulepath to make them available on the current shell session.

Puhti:

```bash
module use "$PWD/modulefiles/puhti"
```

Mahti:

```bash
module use "$PWD/modulefiles/mahti"
```

LUMI:

```bash
module use "$PWD/modulefiles/lumi"
```

Then, we can load the environments for installing shared Julia packages.

```bash
module load julia/1.9.0 julia-pkg/env
```

Now, we can install packages by running install scripts inside the `packages` directory and instantiate them.

Puhti:

```bash
julia packages/mkl.jl
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/ijulia.jl
julia packages/ijulia_installkernel.jl
julia packages/instantiate.jl
```

Mahti:

```bash
julia packages/mpi.jl
julia packages/cuda.jl
julia packages/ijulia.jl
julia packages/ijulia_installkernel.jl
julia packages/instantiate.jl
```

LUMI:

```bash
julia packages/mpi.jl
julia packages/amdgpu.jl
julia packages/instantiate.jl
```


## Testing Julia and shared packages
Run tests for Julia and shared packages.

```bash
module unload julia-pkg
module load julia/1.9.0 julia-test/env
```

Puhti:

```bash
(cd test/julia && ./sbatch puhti)
(cd test/mpi && ./sbatch puhti)
(cd test/cuda && ./sbatch puhti)
```

Mahti:

```bash
(cd test/julia && ./sbatch mahti)
(cd test/mpi && ./sbatch mahti)
(cd test/cuda && ./sbatch mahti)
```

LUMI:

```bash
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
cp modulefiles/puhti/julia-jupyter/env.lua /appl/modulefiles/julia-jupyter/env.lua
```

Mahti:

```bash
cp modulefiles/mahti/julia/1.9.0.lua /appl/modulefiles/julia/1.9.0.lua
cp modulefiles/mahti/julia-jupyter/env.lua /appl/modulefiles/julia-jupyter/env.lua
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

