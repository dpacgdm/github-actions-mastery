output "web_server_ip" {
  description = "The public IP address of the web server."
  # To find this value, you look at the Terraform documentation for google_compute_instance.
  # It shows that the IP is located inside the network_interface block, in the first
  # access_config, under the attribute 'nat_ip'.
  value       = { for name, instance in google_compute_instance.web_server : name => instance.network_interface[0].access_config[0].nat_ip }
}
