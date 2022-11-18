terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.0"
    }
  }
}

provider "google" {
  project = "gcp-final-project-368718"
  region  = "us-central1"
  zone    = "us-central1-a"

}
