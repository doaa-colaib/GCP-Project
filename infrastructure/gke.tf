resource "google_service_account" "k8-sa" {
  account_id   = "service-account-k8"
  display_name = "Service Account k8"
}

resource "google_container_cluster" "my-cluster" {
  name     = "my-gke-cluster"
  location = "us-central1"

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.my-vpc.name
  subnetwork = google_compute_subnetwork.restricted-subnet.name

  # to make the cluster private
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.5.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.0.0.0/24"
    }
  }
  ip_allocation_policy {}
}

resource "google_container_node_pool" "my_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.my-cluster.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"

    service_account = google_service_account.k8-sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}