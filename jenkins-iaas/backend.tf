terraform {
  backend "s3" {
    bucket = "jenkins-iaas-terraform-state-pranav"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}