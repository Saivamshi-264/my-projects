resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["10.0.0.0/24"]
}
