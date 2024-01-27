resource "aws_instance" "web-1" {
  count                       = 3 #0 1 2
  ami                         = var.imagename
  instance_type               = "t2.micro"
  key_name                    = "ANIL-KEY"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Terraform-Server-${count.index + 1}"
    Env        = lower("PRODUCTION")
    Owner      = lower("anil appala")
    CostCenter = var.CostCenter
  }
  user_data = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y nginx jq unzip stress 
		echo "<center><h1>Deployed via Terraform anil</h1></center>" | sudo tee /var/www/html/index.nginx-debian.html
	EOF
}