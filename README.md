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

Julia directories in the application directory

- Julia installation directory: `julia-v#.#.#`
- Shared Julia depot directory: `depot`
- Directory for Julia kernels for Jupyter: `jupyter`
- Direcotry for Jupyter installation for Julia: `jupyter-env`


## Installing the Julia environment
Downloads and unpacks the binaries to `JULIA_APPLDIR`.

```bash
export JULIA_APPLDIR="/appl/soft/math/julia"
export JULIA_VERSION="1.8.5"
sh julia/binary.sh
```

