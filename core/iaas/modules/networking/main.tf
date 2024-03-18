# create vpc
resource "google_compute_network" "vpc" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

# create subnets
resource "google_compute_subnetwork" "public_subnets" {
  count = length(var.public_subnets)
  name = var.public_subnets[count.index].name
  ip_cidr_range = var.public_subnets[count.index].cidr
  region = var.public_subnets[count.index].region
  network = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "private_subnets" {
  count = length(var.private_subnets)
  name = var.private_subnets[count.index].name
  ip_cidr_range = var.private_subnets[count.index].cidr
  region = var.private_subnets[count.index].region
  network = google_compute_network.vpc.self_link
}

