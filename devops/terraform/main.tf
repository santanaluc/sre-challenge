data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2",]
  }

  filter {
    name = "owner-alias"

    values = ["amazon",]
  }
}

# Instance to create
resource "aws_instance" "challenger_ec2" {
  ami = data.aws_ami.amazon_linux.id 
  instance_type = "t2.small" # used this because t2.micro is too small - necessary 2GBi RAM
  key_name = "tf-key" # key to access
  subnet_id = var.challenger_subnet_public_id
  vpc_security_group_ids = [aws_security_group.connection_rules.id]
  associate_public_ip_address = true
  user_data = "${file("config-ec2.sh")}" # file to install devtools
  tags = {
    Name = "sre-challenge"
  }
}

# Variables to create VPN and Subnet 
variable "challenger_vpc_id" {
  default = "vpc-00b15af04fd2fd8af" 
}

variable "challenger_subnet_public_id" {
  default = "subnet-05b7be80f2a0a3a60"
}

# Security group to access
resource "aws_security_group" "connection_rules" {
  name        = "connection_rules"
  description = "Firewall rules"
  vpc_id      = var.challenger_vpc_id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = " LivenessProbe and ReadinessProbe Port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "connection_rules"
  }
}