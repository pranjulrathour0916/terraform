resource "aws_key_pair" "terra" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}

#vpc

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "security" {
  name        = "Auto SG"
  description = "this is for adding Security group"
  vpc_id      = aws_default_vpc.default.id

  #inbount rule

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for my localhost"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for nginx"
  }

  #outbound rules

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open"
  }
}

#ec2 instance

resource "aws_instance" "terra_instance" {
  key_name        = aws_key_pair.terra.key_name
  security_groups = [aws_security_group.security.name]
  instance_type   = var.instance
  ami             = "ami-05d2d839d4f73aafb" #ubuntu
  user_data = file("install_docker.sh")
  root_block_device {
    volume_size = var.disk_size
    volume_type = var.disk_type
  }
  tags = {
    Name = "terra-instance"
  }
}

resource "aws_s3_bucket" "bucket" {
  
}