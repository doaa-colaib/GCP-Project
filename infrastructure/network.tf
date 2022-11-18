resource "google_compute_network" "my-vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "management-subnet" {
  name          = "management-subnet"
  region        = var.region
  ip_cidr_range = var.management-subnet-cidr
  network       = google_compute_network.my-vpc.id
}

resource "google_compute_subnetwork" "restricted-subnet" {
  name          = "restricted-subnet"
  region        = var.region
  ip_cidr_range = var.restricted-subnet-cidr
  network       = google_compute_network.my-vpc.id
  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "my-router"
  network = google_compute_network.my-vpc.id
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = google_compute_subnetwork.management-subnet.id
    source_ip_ranges_to_nat = [
      "ALL_IP_RANGES"]
  }
  subnetwork {
    name = google_compute_subnetwork.restricted-subnet.id
    source_ip_ranges_to_nat = [
      "ALL_IP_RANGES"]
  }
}

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