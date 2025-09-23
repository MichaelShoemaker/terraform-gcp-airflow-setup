# GCP Airflow VM with Terraform

This project provisions a single Ubuntu VM on Google Cloud Platform using Terraform and cloud-init. The VM installs Docker and Airflow via the provided bootstrap.

## 🚀 What it creates
- An Ubuntu VM on GCP

The VM uses `user-data.yaml` to:
- Create user `gary` with your SSH public key
- Install Docker and Docker Compose
- Clone two GitHub repos
- Run Airflow with Docker Compose

---

## 📂 Project Structure
- `main.tf` → Defines GCP resources (VM)
- `variables.tf` → Variables
- `prod.tfvars` → Values for your GCP deployment
- `outputs.tf` → Shows VM IP + SSH command
- `user-data.yaml` → Cloud-init bootstrap script

---

## 🔑 Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- A GCP project with billing enabled
- Your SSH key pair (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)

---

## ⚙️ Usage
```bash
terraform init
terraform apply -var-file="prod.tfvars"
```

---

## 🧹 Cleanup
Destroy resources when done:
```bash
terraform destroy -var-file="prod.tfvars"
```

---

## 📌 Notes
- Public keys in metadata are safe. Never store private keys in Terraform or GCP.
- For production, consider **OS Login** instead of metadata-based SSH keys.
- After apply, the outputs show the VM IP and a ready-to-copy SSH command.
