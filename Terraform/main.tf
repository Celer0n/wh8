provider "aws" {
  region  = var.region
  profile = var.profile
}

resource "aws_instance" "ubuntu" {
  ami           = var.ami_id_ubuntu
  instance_type = var.instance_type
  key_name        = aws_key_pair.front_key.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
  }

  # root block device
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  # ebs block device
  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  vpc_security_group_ids = [aws_security_group.nginx_sg_for_project.id]

  tags = {
    Name = "ubuntu"
  }
}

resource "aws_instance" "rhel" {
  ami           = var.ami_id_rhel
  instance_type = var.instance_type
  key_name        = aws_key_pair.back_key.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
  }

  # root block device
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  # ebs block device
  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  vpc_security_group_ids = [aws_security_group.nginx_sg_for_project.id]

  tags = {
    Name = "redhat"
  }
}

resource "aws_security_group" "nginx_sg_for_project" {
  name        = "nginx_sg_for_projec"
  description = "Allow HTTP, HTTPS, and SSH access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "front_key" {
  key_name   = "ubuntu-key"      # Дайте уникальное имя для ключа фронтенд-инстанса
  public_key = file("~/.ssh/ubuntu.pub")  # Укажите путь к публичному ключу на локальном компьютере
}

resource "aws_key_pair" "back_key" {
  key_name   = "rhel-key"      # Дайте уникальное имя для ключа фронтенд-инстанса
  public_key = file("~/.ssh/rhel.pub")  # Укажите путь к публичному ключу на локальном компьютере
}
