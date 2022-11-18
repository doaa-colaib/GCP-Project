resource "google_service_account" "mang-sa" {
  account_id   = "serviceaccountid1"
  display_name = "Service Account 1"
}

resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.my-vpc.name
    subnetwork = google_compute_subnetwork.management-subnet.name
//    access_config {
//      // Ephemeral public IP
//      nat_ip = google_compute_address.nat-ip.address
//    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.mang-sa.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")
//  = file("./startup-script.sh")

}