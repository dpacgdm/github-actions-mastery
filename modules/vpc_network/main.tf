# This is the resource that the error message says is missing.
resource "google_compute_network" "main" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  project       = var.project_id
  name          = "${var.network_name}-public"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.main.id # This line depends on the resource above
  region        = "us-central1"
}
