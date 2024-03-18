variable "region" {
  description = "The region in which the resources will be deployed"
  type        = string
}

variable "vpc_details" {
  description = "The details of the VPC"
  type        = object({
    name = string
    cidr = string
    public_subnets = list(object({
      name = string
      cidr = string
    }))
    private_subnets = list(object({
      name = string
      cidr = string
    }))
  })
}

variable "ec2_instance_details" {
  description = "The details of the EC2 instance"
  type        = object({
    ami_id = string
    instance_type = string
    public_key    = string
    user_data_file_path = string
    tag_name = string
    owner = string
    team = string
  })
}
