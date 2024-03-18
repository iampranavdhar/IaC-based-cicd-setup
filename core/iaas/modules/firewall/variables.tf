variable "firewall_name" {
    description = "The name of firewall"
    type        = string
    default     = "core"
}

variable "vpc_name" {
    description = "The name of VPC"
    type        = string
}

variable "allow_http_firewall_target_tags" {
    description = "The target tags for HTTP firewall rule"
    type        = list(string)
}

variable "allow_ssh_firewall_target_tags" {
    description = "The target tags for SSH firewall rule"
    type        = list(string)
}