resource "google_compute_network" "vpc" {
  name                    = "my-private-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
}
