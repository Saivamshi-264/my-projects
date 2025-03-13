resource "google_compute_health_check" "http_health_check" {
  name                = "http-health-check"
  timeout_sec         = 5
  check_interval_sec  = 10
  http_health_check {
    port = 80
  }
}
