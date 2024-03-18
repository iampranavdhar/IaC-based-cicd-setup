variable "region" {
  description = "The region in which the resources will be deployed"
  type        = string
  default     = "us-central1"
}

variable "project" {
  description = "The GCP project in which the resources will be deployed"
  type        = string
  default     = "my-dc-setup"
}

variable "pub_key_path" {
  description = "The path to the public key"
  type        = string
}

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

variable "firewall_name" {
  description = "The name of the firewall"
  type        = string
}

# Instance
variable "pub_instance_details" {
  description = "The details of the instance"
  type        = object({
    name = string
    instance_type = string
    zone = string
    tags = list(string)
    user_data_file_path = string
    owner = string
    is_enable_external_ip = bool
  })
}

variable "priv_instance_details" {
  description = "The details of the instance"
  type        = object({
    name = string
    instance_type = string
    zone = string
    tags = list(string)
    owner = string
    is_enable_external_ip = bool
  })
}