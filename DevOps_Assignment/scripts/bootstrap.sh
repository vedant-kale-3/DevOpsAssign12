#!/usr/bin/env bash
set -e
echo "=== DevOps Assignment bootstrap ==="
echo "1) Terraform init & apply (you must set AWS creds as env vars)"
pushd terraform
terraform init
terraform apply -auto-approve
popd
echo "2) Terraform created terraform/terraform-key.pem (use it to SSH/Ansible)"
echo "3) Fill ansible/inventory.ini with IPs from Terraform outputs and run Ansible playbooks:"
echo "   ansible-playbook -i ansible/inventory.ini ansible/playbook.yml"
echo "4) Build Docker images and deploy stack on Swarm manager:"
echo "   docker build -t devops_assignment_web:latest -f docker/web/Dockerfile ."
echo "   docker --context manager swarm init # run on manager"
echo "   docker stack deploy -c docker/stack-docker-compose.yml myapp"
echo "Notes: This script is a helper — some steps require manual values, see READMEs."
