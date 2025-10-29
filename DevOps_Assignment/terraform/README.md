Terraform notes:
- Replace <AMI_ID> with an Ubuntu 20.04 LTS AMI id for your region.
- Set AWS credentials as environment variables before running:
  export AWS_ACCESS_KEY_ID=...
  export AWS_SECRET_ACCESS_KEY=...
- Run:
  terraform init
  terraform apply -auto-approve
- The private key will be saved as terraform/terraform-key.pem
