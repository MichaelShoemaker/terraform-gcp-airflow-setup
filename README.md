# GCP + VirtualBox Airflow Setup with Terraform

This project provisions a basic data engineering playground on **Google Cloud Platform (prod)** or **VirtualBox (test)** using Terraform and cloud-init.

## 🚀 What it creates
- In **prod mode**:
  - A Google Cloud Storage bucket
  - A BigQuery dataset
  - An Ubuntu VM on GCP
- In **test mode**:
  - A local Ubuntu VM on VirtualBox

Both modes use the same `user-data.yaml` bootstrap to:
- Create user `gary` with your SSH public key
- Install Docker and Docker Compose
- Clone two GitHub repos
- Run Airflow with Docker Compose

---

## 📂 Project Structure
- `main.tf` → Defines GCP + VirtualBox resources
- `variables.tf` → Shared variables
- `prod.tfvars` → Values for production (GCP)
- `test.tfvars` → Values for testing (VirtualBox)
- `outputs.tf` → Shows VM IP + SSH command (GCP only)
- `user-data.yaml` → Cloud-init bootstrap script

---

## 🔑 Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install) (for prod)
- [VirtualBox](https://www.virtualbox.org/) + [terraform-provider-virtualbox](https://github.com/terra-farm/terraform-provider-virtualbox) (for test)
- A GCP project with billing enabled (for prod)
- Your SSH key pair (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)

---

## ⚙️ Usage

### Test (local VirtualBox VM)
```bash
terraform init
terraform apply -var-file="test.tfvars"
```

### Prod (GCP VM + bucket + dataset)
```bash
terraform init
terraform apply -var-file="prod.tfvars"
```

---

## 🧹 Cleanup
Destroy resources when done:
```bash
terraform destroy -var-file="test.tfvars"  # Local test
terraform destroy -var-file="prod.tfvars"  # GCP prod
```

---

## 📌 Notes
- Public keys in metadata are safe. Never store private keys in Terraform or GCP.  
- For production, consider **OS Login** instead of metadata-based SSH keys.  
- VirtualBox resources are only created in `test` mode, GCP resources only in `prod` mode.  

Enjoy your hybrid GCP + VirtualBox Airflow playground! 🎉
