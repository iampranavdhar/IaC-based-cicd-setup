output "vpc_id" {
  value = google_compute_network.vpc.self_link
}

output "public_subnet_ids" {
  value = google_compute_subnetwork.public_subnets.*.self_link
}

output "private_subnet_ids" {
  value = google_compute_subnetwork.private_subnets.*.self_link
}