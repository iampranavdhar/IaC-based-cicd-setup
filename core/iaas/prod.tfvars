# Location
region="us-central1"

# Network
vpc_name = "tf-prac-core-vpc"
public_subnets = [ {
    "name": "tf-prac-public-subnet-1",
    "region": "us-central1",
    "cidr" = "10.0.1.0/25"
} ]
private_subnets = [ {
    "name": "tf-prac-private-subnet-1",
    "region": "us-central1",
    "cidr" = "10.0.2.0/25"
} ]

# Firewall
firewall_name = "tf-prac-firewall"

# Compute
pub_instance_details = {
    name = "tf-prac-pub-instance",
    region = "us-central1",
    zone = "us-central1-a",
    instance_type = "e2-micro",
    tags = [ "allow-ssh","allow-http" ]
    user_data_file_path = "scripts/apache-installer.sh"
    owner = "pranav"
    is_enable_external_ip = true
}

priv_instance_details = {
    name = "tf-prac-priv-instance",
    region = "us-central1",
    zone = "us-central1-a",
    instance_type = "e2-micro",
    tags = [ "allow-ssh" ]
    owner = "pranav"
    is_enable_external_ip = false
}