# gcp compute instance
resource "google_compute_instance" "instance" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone
  tags         = var.instance_tags
  boot_disk {
    initialize_params {
      image = var.instance_image
    }
  }
  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet_id
    dynamic "access_config" {
      for_each = var.is_enable_external_ip ? [1] : []
      content {
        // Omitting this block will use the ephemeral external IP
        nat_ip = null
      }
    }
  }

   metadata_startup_script = var.user_data_file_path != "" ? file(var.user_data_file_path) : ""

  metadata = {
    ssh-keys = "${var.owner}:${file(var.public_key_path)}"
  }
}