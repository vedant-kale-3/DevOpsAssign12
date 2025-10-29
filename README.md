DevOps Assignment - Template Repository
======================================

This repository contains templates and code to help complete the assignment:

Structure:
- terraform/  : Terraform templates (placeholders)
- ansible/    : Inventory and playbook to install Docker & init Swarm
- docker/     : Dockerfiles and a stack compose file for Docker Swarm
- django_app/ : Minimal Django app implementing register/login/home/logout
- ci/         : GitHub Actions workflow template
- scripts/    : bootstrap.sh to run common steps
- selenium/   : simple HTTP-based tests

Important notes:
- You must supply AWS AMI IDs, subnet IDs, and AWS credentials before running Terraform.
- The Ansible inventory must be populated with public IPs terraform outputs.
- Some steps (swarm join tokens) may require manual copy or an orchestrating controller script.
- This template is intended to be run and adapted in VS Code. Follow READMEs in folders.

Branch naming:
- Create a branch named with your Roll No (e.g., ITA700) and push this content.

Good luck! :)
