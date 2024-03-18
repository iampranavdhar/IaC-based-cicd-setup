variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "jenkins-vpc"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type        = list(object({
    name = string
    cidr = string 
  }))
}

variable "private_subnets" {
  description = "The CIDR blocks for the private subnets"
  type        = list(object({
    name = string
    cidr = string 
  }))
}

variable "region" {
  description = "The region in which the resources will be deployed"
  type        = string
  default     = "us-west-2"
}
