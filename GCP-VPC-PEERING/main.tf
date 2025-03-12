# VPC 1
resource "google_compute_network" "vpc1" {
  name                    = var.vpc1_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet1"
  network       = google_compute_network.vpc1.id
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region1
}

# VPC 2
resource "google_compute_network" "vpc2" {
  provider                = google.region2
  name                    = var.vpc2_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet2" {
  provider      = google.region2
  name          = "subnet2"
  network       = google_compute_network.vpc2.id
  ip_cidr_range = "10.1.0.0/24"
  region        = var.region2
}

# VPC Peering
resource "google_compute_network_peering" "vpc1_to_vpc2" {
  name         = "vpc1-to-vpc2"
  network      = google_compute_network.vpc1.id
  peer_network = google_compute_network.vpc2.id
}

resource "google_compute_network_peering" "vpc2_to_vpc1" {
  provider     = google.region2
  name         = "vpc2-to-vpc1"
  network      = google_compute_network.vpc2.id
  peer_network = google_compute_network.vpc1.id
}
