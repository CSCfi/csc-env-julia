# CSC Julia Environment
Ansible playbooks for installing a shared environment for the [Julia language](https://julialang.org/) on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/) and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance clusters.
We install and configure MPI and GPU packages in the shared environment.
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for environment modules and [Slurm](https://slurm.schedmd.com/) for managing workloads.
Documentation is available for the [using the Julia application](https://docs.csc.fi/apps/julia/) and [running Julia on the cluster](https://docs.csc.fi/support/tutorials/julia/).

Setup

```bash
python3 -m pip install --user ansible-core
```

Usage

```bash
./install puhti julia 1.10.2
```
