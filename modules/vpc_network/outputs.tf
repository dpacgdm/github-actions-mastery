output "network_name" {
  description = "The name of the VPC network created."
  value       = google_compute_network.main.name
}

# THIS IS THE BLOCK THAT IS LIKELY MISSING
output "public_subnet_self_link" {
  description = "The self_link of the public subnet."
  value       = google_compute_subnetwork.public.self_link
}
