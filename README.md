# csc-env-julia
Ansible playbooks for installing a shared environment for the [Julia language](https://julialang.org/) on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/), and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance computing clusters.
The environments include plain Julia using official binaries and global [preferences](https://github.com/JuliaPackaging/Preferences.jl) for using system installation binaries for [MPI.jl](https://github.com/JuliaParallel/MPI.jl), [CUDA.jl](https://github.com/JuliaGPU/CUDA.jl), and [AMDGPU.jl](https://github.com/JuliaGPU/AMDGPU.jl).
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for environment modules and [Slurm](https://slurm.schedmd.com/) for managing workloads.
Documentation is available for [using the Julia environment](https://docs.csc.fi/apps/julia/) and [running Julia batch jobs on the cluster](https://docs.csc.fi/support/tutorials/julia/).
We aim to follow the conventions described on the [Julia on HPC clusters](https://juliahpc.github.io/) page.

The `Argcfile.sh` wrapper script for installing different environments depends on [argc](https://github.com/sigoden/argc) and [ansible](https://github.com/ansible/ansible).
We can use it as follows:

```bash
argc install-julia-linux-x86-64 --version 1.10.2 --target puhti
```

For more information, use `argc --help`.
