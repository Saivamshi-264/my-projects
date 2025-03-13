output "load_balancer_ip" {
  description = "Internal Load Balancer IP"
  value       = google_compute_forwarding_rule.internal_lb.self_link
}
