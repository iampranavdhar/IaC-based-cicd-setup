# Get latest ubuntu image from GCP marketplace
data "google_compute_image" "latest_image" {
    family  = "ubuntu-2004-lts"
    project = "ubuntu-os-cloud"
}