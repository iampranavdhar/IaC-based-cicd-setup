module "network" {
    source = "./modules/networking"

    vpc_name = var.vpc_name
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
}

# create firewalls
module "firewall" {
    source = "./modules/firewall"

    firewall_name = var.firewall_name
    vpc_name = var.vpc_name
    allow_http_firewall_target_tags =  var.pub_instance_details.tags
    allow_ssh_firewall_target_tags = var.pub_instance_details.tags

    depends_on = [module.network]
}

# create public instance
module "public_instance" {
    source = "./modules/compute"

    vpc_name = var.vpc_name
    instance_name = var.pub_instance_details.name
    instance_type = var.pub_instance_details.instance_type
    zone = var.pub_instance_details.zone
    instance_tags = var.pub_instance_details.tags
    instance_image = data.google_compute_image.latest_image.self_link
    subnet_id = module.network.public_subnet_ids[0]
    user_data_file_path = var.pub_instance_details.user_data_file_path
    owner = var.pub_instance_details.owner
    public_key_path = var.pub_key_path
    is_enable_external_ip = var.pub_instance_details.is_enable_external_ip
}

# create private instance
module "private_instance" {
    source = "./modules/compute"

    vpc_name = var.vpc_name
    instance_name = var.priv_instance_details.name
    instance_type = var.priv_instance_details.instance_type
    zone = var.priv_instance_details.zone
    instance_tags = var.priv_instance_details.tags
    instance_image = data.google_compute_image.latest_image.self_link
    subnet_id = module.network.private_subnet_ids[0]
    owner = var.priv_instance_details.owner
    public_key_path = var.pub_key_path
    is_enable_external_ip = var.priv_instance_details.is_enable_external_ip
}
