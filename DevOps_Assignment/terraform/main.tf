# Terraform template (placeholders — fill before running)
provider "aws" {
  region = "us-east-1"
  # insert your credentials via environment variables:
  # AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.module}/terraform-key.pem"
}

resource "aws_key_pair" "deployer" {
  key_name   = "devops_assignment_key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_security_group" "sg" {
  name        = "devops_assignment_sg"
  description = "Allow SSH, HTTP"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# NOTE: The following EC2 resources require a valid AMI id and subnet.
# Replace <AMI_ID> and <SUBNET_ID> with appropriate free-tier Ubuntu AMI/subnet values.
resource "aws_instance" "controller" {
  ami           = "<AMI_ID>"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.sg.name]
  tags = { Name = "controller" }
}

resource "aws_instance" "manager" {
  ami           = "<AMI_ID>"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.sg.name]
  tags = { Name = "swarm_manager" }
}

resource "aws_instance" "worker_a" {
  ami           = "<AMI_ID>"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.sg.name]
  tags = { Name = "swarm_worker_a" }
}

resource "aws_instance" "worker_b" {
  ami           = "<AMI_ID>"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.sg.name]
  tags = { Name = "swarm_worker_b" }
}

# Elastic IPs (associate manually after instances are running or add depends_on)
resource "aws_eip" "manager_eip" {
  instance = aws_instance.manager.id
}

resource "aws_eip" "worker_a_eip" {
  instance = aws_instance.worker_a.id
}

resource "aws_eip" "worker_b_eip" {
  instance = aws_instance.worker_b.id
}

output "controller_public_ip" {
  value = aws_instance.controller.public_ip
}

output "manager_public_ip" {
  value = aws_eip.manager_eip.public_ip
}

output "worker_a_public_ip" {
  value = aws_eip.worker_a_eip.public_ip
}

output "worker_b_public_ip" {
  value = aws_eip.worker_b_eip.public_ip
}
