variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = ""
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to deploy the VM in"
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
  default     = "airflow-vm"
}

variable "vm_machine_type" {
  description = "The machine type for the GCP VM"
  type        = string
  default     = "e2-medium"
}

variable "vm_disk_size_gb" {
  description = "Disk size for the GCP VM in GB"
  type        = number
  default     = 15
}

variable "ssh_user" {
  description = "The username to create on the VM"
  type        = string
  default     = "gary"
}
