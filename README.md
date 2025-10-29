Ansible notes:
- After Terraform, copy the public IPs into inventory.ini.
- Run from the controller machine:
  ansible-playbook -i inventory.ini playbook.yml
- The playbook installs Docker and tries to init swarm on manager.
- Worker join step is left as a manual step (copy token from manager).
