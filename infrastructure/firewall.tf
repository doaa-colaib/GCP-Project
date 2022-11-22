resource "google_compute_firewall" "ssh-firewall" {
  name    = "fw-allow-ssh"
  network = google_compute_network.my-vpc.name
  direction = "INGRESS"
  source_ranges =  [ "35.235.240.0/20" ]

  allow {
    protocol = "tcp"
    ports    = ["22","80"]
  }
}