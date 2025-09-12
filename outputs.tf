output "vm_ip" {
  description = "External IP address of the GCP VM (prod only)"
  value       = google_compute_instance.prod_vm[0].network_interface[0].access_config[0].nat_ip
  condition   = var.environment == "prod"
}

output "ssh_command" {
  description = "SSH command to connect to the GCP VM as the specified user (prod only)"
  value       = "ssh -i ~/.ssh/id_rsa ${var.ssh_user}@${google_compute_instance.prod_vm[0].network_interface[0].access_config[0].nat_ip}"
  condition   = var.environment == "prod"
}
