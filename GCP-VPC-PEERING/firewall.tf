# Allow VPC 1 to talk to VPC 2
resource "google_compute_firewall" "allow_vpc1_to_vpc2" {
  name    = "allow-vpc1-to-vpc2"
  network = google_compute_network.vpc1.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["10.1.0.0/24"]
}

# Allow VPC 2 to talk to VPC 1
resource "google_compute_firewall" "allow_vpc2_to_vpc1" {
  provider = google.region2
  name     = "allow-vpc2-to-vpc1"
  network  = google_compute_network.vpc2.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["10.0.0.0/24"]
}
