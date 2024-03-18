module "networking" {
    source = "./modules/networking"

    region = var.region
    vpc_cidr_block = var.vpc_details.cidr
    public_subnets = var.vpc_details.public_subnets
    private_subnets = var.vpc_details.private_subnets
}

module "security" {
    source = "./modules/security"
    
    vpc_id = module.networking.vpc_id
}

module "ec2" {
    source = "./modules/ec2"
    
    ami_id = var.ec2_instance_details.ami_id
    instance_type = var.ec2_instance_details.instance_type
    tag_name = var.ec2_instance_details.tag_name
    owner = var.ec2_instance_details.owner
    team = var.ec2_instance_details.team
    public_key = file(var.ec2_instance_details.public_key)
    subnet_id = module.networking.public_subnet_ids[0]
    security_group_ids = [module.security.jenkins_sg_id]
    enable_public_ip_address = true
    user_data = file(var.ec2_instance_details.user_data_file_path)
}
