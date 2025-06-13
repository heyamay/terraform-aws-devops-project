# modules/ec2/main.tf

resource "aws_security_group" "ec2_sg" {
  name        = "${var.ec2_name_prefix}-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ec2_name_prefix}-sg"
  }
}

resource "aws_instance" "web" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index % length(var.subnet_ids)) # Distribute instances across subnets
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.ssh_key_name
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = "${var.ec2_name_prefix}-${count.index + 1}"
  }

  # Example user data to install Nginx
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "<h1>Hello from Terraform EC2 Instance ${count.index + 1}!</h1>" | sudo tee /usr/share/nginx/html/index.html
              EOF
}
