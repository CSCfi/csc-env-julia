# csc-env-julia
Ansible playbooks for installing a shared environment for the [Julia language](https://julialang.org/) on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/) and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance clusters.
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for environment modules and [Slurm](https://slurm.schedmd.com/) for managing workloads.
Documentation is available for the [using the Julia environment](https://docs.csc.fi/apps/julia/) and [running Julia batch jobs on the cluster](https://docs.csc.fi/support/tutorials/julia/).
We aim to follow the conventions described in the [Julia on HPC clusters](https://juliahpc.github.io/JuliaOnHPCClusters/) page.

The repository is structured as follows:

- `julia` directory contains a playbook and files for installing the official Julia binaries and a modulefile for loading Julia to the environment and setting default thread counts.
- Playbooks and files for installing global preferences and a modulefile for loading them
  - `mpi` for MPI.jl
  - `cuda` for CUDA.jl
  - `amdgpu` for AMDGPU.jl
- `hosts.yaml` contains the ansible hosts and the associated variables.
- `install.sh` is a wrapper script for installing targets with Ansible.


## Usage
We need to install Ansible core for the configuration.

```bash
python3 -m pip install --user ansible-core
```

We can use the wrapper script to perform installations:

```bash
./install.sh puhti julia 1.10.2
```

For more information, use the help flag:

```bash
argc --help
```
