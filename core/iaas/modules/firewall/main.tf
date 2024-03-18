resource "google_compute_firewall" "allow-http" {
    name    = "${var.firewall_name}-fw-allow-http"
    network = var.vpc_name
    allow {
        protocol = "tcp"
        ports    = ["80", "8080"]
    }
    target_tags = var.allow_http_firewall_target_tags

}

resource "google_compute_firewall" "allow-ssh" {
    name    = "${var.firewall_name}-fw-allow-ssh"
    network = var.vpc_name
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = [ "103.109.144.40/32" ]
    target_tags = var.allow_ssh_firewall_target_tags
}
