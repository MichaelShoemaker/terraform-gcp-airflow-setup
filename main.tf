# --- Providers ---
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "virtualbox" {}

# --- GCS bucket (prod only) ---
resource "google_storage_bucket" "data_bucket" {
  count    = var.environment == "prod" ? 1 : 0
  name     = var.bucket_name
  location = var.region
}

# --- BigQuery dataset (prod only) ---
resource "google_bigquery_dataset" "dataset" {
  count                      = var.environment == "prod" ? 1 : 0
  dataset_id                 = var.bq_dataset_id
  location                   = var.region
  delete_contents_on_destroy = true
}

# --- Ubuntu VM on GCP (prod only) ---
resource "google_compute_instance" "prod_vm" {
  count        = var.environment == "prod" ? 1 : 0
  name         = var.vm_name
  machine_type = var.vm_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = var.vm_disk_size_gb
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  metadata = {
    user-data = file("${path.module}/user-data.yaml")
  }
}

# --- VirtualBox VM (test only) ---
resource "virtualbox_vm" "test_vm" {
  count     = var.environment == "test" ? 1 : 0
  name      = var.vm_name
  image     = "https://app.vagrantup.com/ubuntu/boxes/focal64/versions/20211029.0.0/providers/virtualbox.box"
  cpus      = 2
  memory    = "2048 mib"
  user_data = file("${path.module}/user-data.yaml")
}
