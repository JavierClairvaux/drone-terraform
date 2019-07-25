provider "aws" {
  region  = var.region
}

resource "aws_instance" "drone" {
  ami            = var.drone-ami
  instance_type  = var.drone-instance
  security_groups = [ var.security-grp-name ]
  key_name        = var.drone-key

  tags = {
    Name = "Drone"
  }

  provisioner "local-exec" {
    command = "echo [drone] > inventory"
  }

  provisioner "local-exec" {
    command = "echo  ${self.public_ip} ansible_user=${var.instance_user} >> inventory"
  }

  provisioner "local-exec" {
    command = "echo  drone_ip: ${self.public_ip} > roles/setup-drone/vars/drone_ip.yml"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory --private-key ${var.drone-key}.pem playbook.yml"
  }
}

resource "aws_security_group" "allow_http_ssh" {
    name    = var.security-grp-name
    description =var.securty-grp-description

    ingress {
    # TLS (change to whatever ports you need)
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
