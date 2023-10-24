Installation using Ansible

```bash
ansible-playbook -i hosts.yaml -l group_puhti -e @julia/1.9.3.yaml --check julia.yaml
```
