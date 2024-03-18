resource "aws_instance" "jenkins_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name  = var.tag_name
    Owner = var.owner
    Team  = var.team
  }
  key_name                    = "jenkins_proj_public_key"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data

  metadata_options {
    http_endpoint = "enabled" 
    http_tokens   = "required"
  }
}

resource "aws_key_pair" "jenkins_proj_public_key" {
  key_name   = "jenkins_proj_public_key"
  public_key = var.public_key
}
