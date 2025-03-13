resource "google_compute_instance" "vm_instances" {
  count        = var.instance_count
  name         = "private-vm-${count.index}"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20250212"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.private_subnet.id
    access_config {}
  }
}
