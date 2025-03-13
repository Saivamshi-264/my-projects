resource "google_compute_instance_group" "instance_group" {
  name        = "my-instance-group"
  zone        = var.zone
  instances   = google_compute_instance.vm_instances[*].self_link
  network     = google_compute_network.vpc.id
}

resource "google_compute_backend_service" "backend" {
  name                  = "backend-service"
  health_checks         = [google_compute_health_check.http_health_check.id]
  load_balancing_scheme = "INTERNAL_MANAGED"
  backend {
    group = google_compute_instance_group.instance_group.id
  }
}

resource "google_compute_forwarding_rule" "internal_lb" {
  name                  = "internal-load-balancer"
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  backend_service       = google_compute_backend_service.backend.id
  ip_protocol           = "TCP"
  ports                 = ["80"]
  network               = google_compute_network.vpc.id
}
