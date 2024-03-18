variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "core-vpc"
}

variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type        = list(object({
    name = string
    cidr = string
    region = string
  }))
}

variable "private_subnets" {
  description = "The CIDR blocks for the private subnets"
  type        = list(object({
    name = string
    cidr = string
    region = string 
  }))
}

