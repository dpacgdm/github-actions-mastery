terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}



provider "google" {
  project = var.gcp_project_id
  region = var.gcp_region
}

resource "google_storage_bucket" "learning_bucket" {
  name = var.bucket_name
  location = var.bucket_location
}
