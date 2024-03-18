variable "ami_id" {
    description = "The ID of the AMI to use for the EC2 instance"
    type        = string
}

variable "instance_type" {
    description = "The type of EC2 instance to launch"
    type        = string
}

variable "tag_name" {
    description = "The name of the EC2 instance"
    type        = string
}

variable "owner" {
    description = "The owner of the EC2 instance"
    type        = string
}

variable "team" {
    description = "The team responsible for the EC2 instance"
    type        = string
}

variable "public_key" {
    description = "The public key to use for SSH access"
    type        = string
}

variable "subnet_id" {
    description = "The ID of the subnet in which to launch the EC2 instance"
    type        = string
}

variable "security_group_ids" {
    description = "The IDs of the security groups to associate with the EC2 instance"
    type        = list(string)
}

variable "enable_public_ip_address" {
    description = "Whether to associate a public IP address with the EC2 instance"
    type        = bool
}

variable "user_data" {
    description = "The user data to provide when launching the EC2 instance"
    type        = string
}

