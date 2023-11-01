# CSC Julia Environment
Instructions for installing the [Julia language](https://julialang.org/) and configuring a shared environment on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/) and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance clusters.
We install and configure MPI and GPU packages in the shared environment.
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for environment modules and [Slurm](https://slurm.schedmd.com/) for managing workloads.
The [Julia source code](https://github.com/JuliaLang/julia) is at GitHub.

Install Julia and modulefiles

```bash
ansible-playbook -i hosts.yaml -l group_puhti -e @julia/version/1.9.3.yaml julia/install.yaml --check
```

Install Jupyter for Julia

```bash
ansible-playbook -i hosts.yaml -l group_puhti jupyter/install.yaml --check
```
