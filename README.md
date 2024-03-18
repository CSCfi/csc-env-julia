# CSC Julia Environment
Ansible playbooks for installing a shared environment for the [Julia language](https://julialang.org/) on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/) and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance clusters.
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for environment modules and [Slurm](https://slurm.schedmd.com/) for managing workloads.
Documentation is available for the [using the Julia application](https://docs.csc.fi/apps/julia/) and [running Julia on the cluster](https://docs.csc.fi/support/tutorials/julia/).
More information about [Julia on HPC clusters](https://juliahpc.github.io/JuliaOnHPCClusters/).

Directory structure

- `install.sh` wrapper script for installing targets with Ansible.
- `hosts.yaml` contains the ansible hosts and the associated variables.
- `julia` contains playbook for installing Julia and corresponding modulefile.
- `mpi` contains playbook for installing global MPI.jl preferences and corresponding modulefile.
- `cuda` contains playbook for installing global CUDA.jl preferences and corresponding modulefile.
- `amdgpu` contains playbook for installing global AMDGPU.jl preferences and corresponding modulefile.

We need to install Ansible for the configuration.

```bash
python3 -m pip install --user ansible-core
```

We can use the wrapper script to perform installations:

```bash
./install.sh puhti julia 1.10.2
```

For more information, use the help flag:

```bash
./install.sh --help
```
