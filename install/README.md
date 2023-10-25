Install Julia and modulefiles

```bash
ansible-playbook -i hosts.yaml -l group_puhti -e @julia/1.9.3.yaml --check julia.yaml
```

Install Julia-Jupyter

```bash
ansible-playbook -i hosts.yaml -l group_puhti --check julia-jupyter.yaml
```
