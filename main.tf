provider "google" {
  project = "devops-sprint-project"
  region  = "us-central1"
}

module "app_vpc" {
  source       = "./modules/vpc_network"
  project_id   = "devops-sprint-project"
  network_name = "web-app-network-${terraform.workspace}"
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-${terraform.workspace}"
  network = module.app_vpc.network_name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Requirement 1: Create a dedicated service account
resource "google_service_account" "web_server_sa" {
  account_id   = "web-server-sa-${terraform.workspace}"
  display_name = "Web Server Service Account (${terraform.workspace})"
}

resource "google_compute_instance" "web_server" {
  # This section is unchanged from the previous module.
  for_each = toset([for i in range(2) : format("%d", i)])
  name         = "web-server-${terraform.workspace}-${each.key}"
  machine_type = "e2-micro" # Start with a compliant type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = module.app_vpc.public_subnet_self_link
    access_config {}
  }

  metadata_startup_script = "#!/bin/bash\napt-get update\napt-get install -y nginx\nsystemctl start nginx"
  
  # Requirement 2: Use the created service account
  service_account {
    # CORRECTED: Reference the email attribute of the resource we created.
    email  = google_service_account.web_server_sa.email
    scopes = ["cloud-platform"]
  }
  
  lifecycle {
    # Requirement 3: Implement Policy 1 (Service Account must exist)
    postcondition {
      # CORRECTED: Added the required 'condition' and 'error_message' arguments.
      condition     = self.service_account[0].email != null
      error_message = "A specific service account must be used; the default is not allowed."
    }
    
    # Requirement 4: Implement Policy 2 (dev machine type must be small)
    postcondition {
      # CORRECTED: Implemented the logic using standard operators.
      condition     = (terraform.workspace != "dev") || contains(["e2-micro", "e2-small", "e2-medium"], self.machine_type)
      error_message = "Machine type '${self.machine_type}' is not allowed in the 'dev' environment. Allowed types are e2-micro, e2-small, e2-medium."
    }
  }
}
