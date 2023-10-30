Install Julia and modulefiles

```bash
ansible-playbook -i hosts.yaml -l group_puhti -e @julia/version/1.9.3.yaml julia/install.yaml --check
```

Install Julia-Jupyter

```bash
ansible-playbook -i hosts.yaml -l group_puhti julia-jupyter-env/install.yaml --check
```
