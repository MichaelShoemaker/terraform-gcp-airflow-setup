provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# ----------------------------
# Service Account
# ----------------------------
resource "google_service_account" "vm_sa" {
  account_id   = "${var.vm_name}-sa"
  display_name = "Service account for ${var.vm_name}"
}

# ----------------------------
# IAM Permissions
# ----------------------------

# BigQuery Admin (full control over BigQuery)
resource "google_project_iam_member" "bq_admin" {
  project = var.project_id
  role    = "roles/bigquery.admin"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

# Cloud Storage Object Admin (read/write/delete objects)
resource "google_project_iam_member" "gcs_object_admin" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

# ----------------------------
# Compute VM
# ----------------------------
resource "google_compute_instance" "vm" {
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

  # Attach service account (metadata-based auth)
  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    ssh-keys  = "${var.ssh_user}:${file("~/.ssh/gcp.pub")}"
    user-data = file("${path.module}/user-data.yaml")
  }
}
