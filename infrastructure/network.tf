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

