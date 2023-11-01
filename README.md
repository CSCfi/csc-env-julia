# CSC Julia Environment
Ansible playbooks for installing a shared environment for the [Julia language](https://julialang.org/) on [Puhti](https://docs.csc.fi/computing/systems-puhti/), [Mahti](https://docs.csc.fi/computing/systems-mahti/) and [LUMI](https://docs.lumi-supercomputer.eu/) high-performance clusters.
We install and configure MPI and GPU packages in the shared environment.
The clusters use [Lmod](https://lmod.readthedocs.io/en/latest/) for environment modules and [Slurm](https://slurm.schedmd.com/) for managing workloads.

Install Julia and modulefiles

```bash
ansible-playbook -i hosts.yaml -l group_puhti -e @julia/version/1.9.3.yaml julia/install.yaml
```

Install Jupyter for Julia

```bash
ansible-playbook -i hosts.yaml -l group_puhti jupyter/install.yaml
```
