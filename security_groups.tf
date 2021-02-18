resource "aws_security_group" "sg" {
  name = var.project_name
}

resource "aws_security_group_rule" "ssh_cidr" {
  from_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  to_port = 22
  type = "ingress"
  cidr_blocks = var.in_cidr_blocks
}

resource "tls_private_key" "t" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.t.public_key_openssh
}

resource "local_file" "key" {
  filename = "${var.ssh_key_name}.pem"
  content = tls_private_key.t.private_key_pem
  provisioner "local-exec" {
    command = "chmod 600 ${var.ssh_key_name}.pem"
  }
}

resource "aws_security_group_rule" "ssh_source_security_group" {
  count = length(var.in_source_security_group) > 0 ? 1 : 0

  type = "ingress"
  protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  from_port = 22
  to_port = 22
  source_security_group_id = var.in_source_security_group
}

resource "aws_security_group_rule" "http_cidr" {
  from_port = 8080
  protocol = "tcp"
  security_group_id = aws_security_group.sg.id
  to_port = 8080
  type = "ingress"
  cidr_blocks = var.in_cidr_blocks
}

resource "aws_security_group_rule" "allow_all" {
  type = "egress"
  protocol = -1
  security_group_id = aws_security_group.sg.id
  from_port = 0
  to_port = 0
  cidr_blocks = ["0.0.0.0/0"]
}