output "vpc_id" {
    value = module.network.vpc_id
}

output "public_subnet_ids" {
    value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
    value = module.network.private_subnet_ids
}


output "public_instance_id" {
    value = module.public_instance.instance_id
}
