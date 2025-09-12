variable "environment" {
  description = "Deployment environment (test or prod)"
  type        = string
  default     = "prod"
}

variable "project_id" {
  description = "The GCP project ID (used in prod only)"
  type        = string
  default     = ""
}

variable "region" {
  description = "The region to deploy resources in (prod only)"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to deploy the VM in (prod only)"
  type        = string
  default     = "us-central1-a"
}

variable "bucket_name" {
  description = "The name of the GCS bucket (prod only)"
  type        = string
  default     = "my-data-bucket-12345"
}

variable "bq_dataset_id" {
  description = "The dataset ID for BigQuery (prod only)"
  type        = string
  default     = "my_dataset"
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
  default     = "airflow-vm"
}

variable "vm_machine_type" {
  description = "The machine type for the GCP VM (prod only)"
  type        = string
  default     = "e2-medium"
}

variable "vm_disk_size_gb" {
  description = "Disk size for the GCP VM in GB (prod only)"
  type        = number
  default     = 20
}

variable "ssh_user" {
  description = "The username to create on the VM"
  type        = string
  default     = "gary"
}
