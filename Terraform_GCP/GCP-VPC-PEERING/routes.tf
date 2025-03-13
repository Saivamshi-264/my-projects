# Route from VPC 1 to VPC 2
resource "google_compute_route" "vpc1_to_vpc2_route" {
  name              = "vpc1-to-vpc2-route"
  network           = google_compute_network.vpc1.id
  dest_range        = "10.1.0.0/24"
  next_hop_gateway  = "default-internet-gateway"
  priority          = 1000
}

# Route from VPC 2 to VPC 1
resource "google_compute_route" "vpc2_to_vpc1_route" {
  provider          = google.region2
  name              = "vpc2-to-vpc1-route"
  network           = google_compute_network.vpc2.id
  dest_range        = "10.0.0.0/24"
  next_hop_gateway  = "default-internet-gateway"
  priority          = 1000
}
